#!/usr/bin/env perl
use 5.010;
use strict;
use warnings FATAL => 'all';
use Path::Tiny qw(path);
use Data::Dumper qw(Dumper);
use JSON qw(from_json);

if (@ARGV != 2 and @ARGV != 3) {
    die qq{
Usage: $0 SRC DEST [--relax]

SRC  is the repository where the source are in the src/ subdirectory.
DEST is the repository of the newly created book with the manuscript/ subdirectory.
};
}
my ($src, $dest, $relax) = @ARGV;
$src = path($src)->absolute;
$dest = path($dest)->absolute;
#_log("Source '$src'");
#_log("Destination '$dest'");


# remove all the old files and directories
path("$dest/manuscript/")->remove_tree;


my $chapters = from_json path("$src/book.json")->slurp_utf8;

# Each html page url is used as an id to which other parts might link. The %pages hash is used to look up if a link
# is internal to the book or not.

# Copy resources
path("$dest/manuscript/resources/")->mkpath;
my $resources_path = "$src/src/resources";
my $iter = path($resources_path)->iterator( {
    recurse         => 1,
    follow_symlinks => 0,
} );
while ( my $path = $iter->() ) {
    next if $path->basename eq '.DS_Store';
    my $rel_path = substr $path, length($resources_path) + 1;
    if ($path->is_dir) {
        path("$dest/manuscript/resources/$rel_path")->mkpath;
        next;
    }
    if ($path->is_file) {
        path($path)->copy("$dest/manuscript/resources/$rel_path");
    }
}


my @book;
my %pages;
for my $ch (@$chapters) {
    # assume file to be copied
    if (not ref($ch)) {
        if (substr($ch, 0, 2) eq '..') {
            my $name = path("$ch")->basename;
            path("$ch")->copy("$dest/manuscript/$name");
            push @book, "$name\n";
        } else {
            path("$src/src/$ch")->copy("$dest/manuscript/$ch");
            push @book, "$ch\n";
        }
        next;
    }

    die "DIE - Duplicate id '$ch->{ch}'" if $pages{$ch->{ch}};
    $pages{$ch->{ch}} = 1;
    push @book, "$ch->{ch}.md\n";
    for my $page (@{ $ch->{pages} }) {
        my ($page_id) = $page =~ m{([^/]+)$};
        die "DIE - Duplicate id '$page_id'" if $pages{$page_id};
        $pages{$page_id} = 1;
        push @book, "$page_id.md\n";
    }
}
push @book, "index.md\n";
path("$dest/manuscript/Book.txt")->spew_utf8(@book);
#die Dumper \%pages;

my %index;

my %dirs = (
    'https://perlmaven.com/'     => '/home/gabor/work/perlmaven.com/sites/en/pages',
    'https://perlmaven.com/pro/' => '/home/gabor/work/perlmaven-pro/articles',
    'https://code-maven.com/'    => '/home/gabor/work/code-maven.com/sites/en/pages',
);

my %examples = (
    'https://perlmaven.com/'     => '/home/gabor/work/perlmaven.com',
    'https://perlmaven.com/pro/' => '/home/gabor/work/perlmaven.com',
    'https://code-maven.com/'    => '/home/gabor/work/code-maven.com',
);


for my $ch (@$chapters) {
    # For md files, for each {i: text} entry create an index entry pointing to the 
    #     1. top of the page.
    #     2. the most recent linkable place.
    #     3. replace it by a link and link to that.
    if (not ref($ch)) {
        my $src = "$dest/manuscript/$ch";
        if (substr($ch, 0, 2) eq '..') {
            $src = "$dest/manuscript/" . path($ch)->basename;
        }
        my @input_lines = path($src)->lines_utf8( { chomp => 1 } );
        my $title;
        my $anchor;
        foreach my $line (@input_lines) {
            if ($line =~ /^#+\s+([^{]*?)\s*\{#([^}]+)\}/) {
                ($title, $anchor) = ($1, $2);
            }
            if ($line =~ /\{i:\s+("?)([^}]+)\1}/) {
                my $text = $2;
                push @{ $index{$text} }, {
                    title => $title,
                    id    => $anchor,
                };
            }
        }
        next;
    }

    my $out = "$dest/manuscript/$ch->{ch}.md";
    #_log("out: $out");
    path($out)->spew_utf8("{id: $ch->{ch}}\n# $ch->{title}\n\n");

    for my $page (@{ $ch->{pages} }) {
        my ($page_id) = $page =~ m{([^/]+)$};
        my $url = substr $page, 0, -length($page_id);
        die "DIE - Could not find local directory for '$url'" if not $dirs{$url};
        (my $base_url = $url) =~ s{pro/$}{};

        my $path = $dirs{$url};
        my $examples = $examples{$url};

        #say $page_id;
        my $src = "$path/$page_id.txt";
        my $trg = "$dest/manuscript/$page_id.md";

        my @input_lines = path($src)->lines_utf8( { chomp => 1 } );
        my ($title_line) = grep { $_ =~ /=title\s+/ } @input_lines;
        my $title = substr $title_line, 7;

        my ($sample_line) = grep { $_ =~ /=sample\s+/ } @input_lines;
        my $sample = $sample_line ? 'true' : 'false';

        # collect the indexes
        my ($indexes_line) = grep { $_ =~ /=indexes\s+/ } @input_lines;
        if ($indexes_line) {
            $indexes_line =~ s/=indexes\s+//;
            my @keywords = split /\s*,\s*/, $indexes_line;
            foreach my $k (@keywords) {
                push @{ $index{$k} }, {
                    title => $title,
                    id    => $page_id,
                };
            }
        }

        my $verbatim = 0;
        my @lines =  ("{id: $page_id, sample: $sample}\n", "## $title\n", "\n");
        for my $line (@input_lines) {
            $line =~ s/\s*$//;
            next if $line =~ /^=\w/;    # remove header lines and =abstract lines

            # include images (TODO sholdn't this and the include file be the same code?
            # <img src="/img/excel1.png" alt="Excel example 1" />
            if ($line =~m{<img src="/img/([^"]*)"( alt="([^"]*)")?\s*/?>}) {
                my $src = $1;
                my $alt = $3 || '';

                my $dir = path($src)->dirname;
                path("$dest/manuscript/resources/img/$dir")->mkpath;
                path("$examples/static/img/$src")->copy("$dest/manuscript/resources/img/$src");
                push @lines, "![$alt](img/$src)\n";

                next;
            }

            # include files: <include file=”examples/prompt.pl”>
            if ($line =~ m{<include file="([^"]+)">}) {
                my $src = $1;
                die "DIE - Unsupportd include path '$src'" if substr($src, 0, 9) ne 'examples/';
                my $dir = path($src)->dirname;
                path("$dest/manuscript/resources/$dir")->mkpath;
                path("$examples/$src")->copy("$dest/manuscript/resources/$src");
                if ($src =~ m{/.gitignore} or $src =~ m{/Vagranfile}) {
                    push @lines, "{type: code, format: text}\n";
                }
                push @lines, "![]($src)\n";
                next;
            }

            # handle h2 tags with id: <h2 id="activeperl">ActivePerl</h2>
            if ($line =~ m{^<h2\s+id="([^"]+)">(.*)</h2>}) {
                my ($id, $text) = ($1, $2);
                die "DIE - Duplicate id '$id'" if $pages{$id};
                $pages{$id} = 1;
                push @lines, "{id: $id}\n", "### $text\n";
                next;
            }
            if ($line =~ m{^<h2>(.*)</h2>}) {
                push @lines, "### $1\n";
                next;
            }
            if ($line =~ m{^<h3>(.*)</h3>}) {
                push @lines, "#### $1\n";
                next;
            }

            # What to do with videos?  <iframe width=”640” height=”360” src=”//www.youtube.com/embed/c3qzmJsR2H0” frameborder=”0” allowfullscreen></iframe>
            if ($line =~ m{<iframe [^>]* src="(?:https?:)?//www.youtube.com/embed/([^"]+)"([^>]*)></iframe>}x) {
                warn "WARN - IFRAME: $line";
                my $code = $1;
                $code =~ s/\?.*//;
                push @lines, "[video](https://www.youtube.com/watch?v=$code)\n";
                next;
            }

            # <slidecast file="/media/videos/beginner-perl/common-errors" youtube="Sk7QkRNTIak" />
            if ($line =~ m{<slidecast file="[^"]*" youtube="([^"]*)" />}) {
                warn "WARN - SLIDECAST $line";
                push @lines, "[video](https://www.youtube.com/watch?v=$1)\n";
                next;
            }

#            next if $line =~ m{<!--};
#            next if $line =~ m{-->};

            if ($line =~ m{<code( lang="([^"]*)")?>} or $line =~ m{<pre>}) {
                $verbatim = 1;
                push @lines, "```\n";
                next;
            }

            if ($verbatim) {
                if ($line =~ m{</code>} or $line =~ m{</pre>}) {
                    $verbatim = 0;
                    push @lines, "```";
                    next;
                }

                push @lines, "$line\n";
                next;
            }

            $line =~ s{</?[uo]l>}{}g;              # remove <ul> and <ol>
            $line =~ s{\s*<li>(.*?)</li>}{* $1};   # <li></li>
            $line =~ s{<hr>}{}g;                   # remoe <hr>

            $line =~ s{<hl>(.*?)</hl>}{`$1`}g;     # <hl></hl>
            $line =~ s{<i>(.*?)</i>}{*$1*}g;       # italic (very few)
            $line =~ s{<b>(.*?)</b>}{**$1**}g;     # bold

            $line =~ s{</?strong>}{}g;     # for now let's remove the strong parts

            # Handle external links:  <a href="http://search.cpan.org/dist/Path-Tiny/">
            # Handle nofollow links:  <a href="http://search.cpan.org/dist/Path-Tiny/" rel="nofollow">
            $line =~ s{<a\s+href="(https?://[^"]*)"(?: rel="nofollow")?>(.*?)</a>}{[$2]($1)}g;

            # handle internal links that might refer to another page in the book, or a page on the site that was not included in the book.
            # <a href="/perl-tutorial">Perl tutorial</a>
            # and
            # <a href="/pro/perl-tutorial">Perl tutorial</a>
            # this should only be executed outside of code snippets!
            # TODO: work on the same line multiple times: while $line =~ m{<a href}
            while ($line =~ m{<a href="(/pro)?/([^"]*)">([^<]*)</a>}) {
                my ($pro, $id, $title) = ($1, $2, $3);
                $pro //= '';
                my $replace_pro = $pro ? 'pro/' : '';
                if ($pages{$id}) {
                    $line =~ s{<a href="$pro/$id">([^<]*)</a>}{[$title](#$id)};
                } else {
                    warn "WARN - LINK: $line";
                    $line =~ s{<a href="$pro/$id">([^<]*)</a>}{[$title]($base_url$replace_pro$id)};
                }
            }

            # Handle internal links: <a href="#id">..</a>
            while ($line =~ s{<a href="#([^"]*)">([^<]+)</a>}{[$2](#$1)}) {
                # cannot verify as that part has not been parsed yet.
                #die "DIE - Missing ID '$1'" if not $pages{$1};
            }

            if ($line =~ /^\s*$/) {
                if ($lines[-1] eq "\n") {
                    # no two newlines
                } else {
                    push @lines, "\n", "\n";
                }
            } else {
                push @lines, ($lines[-1] eq "\n" ? '' : ' ') . $line;
            }
       }

       # I think there should be no left over less-than (<) or greater-than (>) signs in the md files.
       # Though there still might be some examples embedded, especially in the Perl tutorials
       # so I might need to relax this check.
       my @errors = grep { $_ =~ /[<>]/ }  @lines;
       if (not $relax) {
           for my $err (@errors) {
               die "DIE - HTML: $err IN page $page";
           }
       }
       _log("out: $trg");
       path($trg)->spew_utf8(@lines);
    }
}

my $index_page = "{id: keyword-index}\n# Index\n\n";
foreach my $k (sort keys %index) {
    $index_page .= "* `$k`\n";
    foreach my $entry (@{ $index{$k} }) {
        $index_page .= sprintf("    * [%s](#%s)\n", $entry->{title}, $entry->{id});
    }
}

path("$dest/manuscript/index.md")->spew_utf8($index_page);

sub _log {
    say shift;
}
