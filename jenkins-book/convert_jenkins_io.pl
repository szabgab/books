#!/usr/bin/env perl
use strict;
use warnings;
use Asciidoc::Parser;
use Data::Dumper;

system "$^X ../books/convert.pl . .";
convert_all();
exit;


sub convert_all {
    my $path = '../jenkins.io/content';
    open my $book, '>>', 'manuscript/Book.txt' or die;  #TODO integrate into the generate script!
    
    my @files = (
        'doc/book/getting-started/index.adoc',
        'doc/book/getting-started/installing.adoc',

        'doc/book/installing/index.adoc',


        'doc/book/using/index.adoc',
#        'doc/book/using/fingerprints.adoc',
#        'doc/book/using/remote-api.adoc',
        'doc/book/using/using-credentials.adoc',

        'doc/book/pipeline/index.adoc',
        'doc/book/pipeline/getting-started.adoc',
        'doc/book/pipeline/development.adoc',
        'doc/book/pipeline/docker.adoc',
        'doc/book/pipeline/jenkinsfile.adoc',
        'doc/book/pipeline/multibranch.adoc',
        'doc/book/pipeline/overview.adoc',
        'doc/book/pipeline/running-pipelines.adoc',
        'doc/book/pipeline/scaling-pipeline.adoc',
        'doc/book/pipeline/shared-libraries.adoc',
        'doc/book/pipeline/syntax.adoc',

        'doc/book/blueocean/index.adoc',
        'doc/book/blueocean/activity.adoc',
        'doc/book/blueocean/creating-pipelines.adoc',
        'doc/book/blueocean/dashboard.adoc',
        'doc/book/blueocean/getting-started.adoc',
        'doc/book/blueocean/pipeline-editor.adoc',
        'doc/book/blueocean/pipeline-run-details.adoc',


        'doc/book/managing/index.adoc',
        'doc/book/managing/cli.adoc',
        'doc/book/managing/nodes.adoc',
        'doc/book/managing/plugins.adoc',
        'doc/book/managing/script-approval.adoc',
        'doc/book/managing/script-console.adoc',
        'doc/book/managing/security.adoc',
        'doc/book/managing/system-configuration.adoc',
        'doc/book/managing/tools.adoc',
        'doc/book/managing/users.adoc',

        'doc/book/system-administration/index.adoc',
        'doc/book/system-administration/backing-up.adoc',
        'doc/book/system-administration/monitoring.adoc',
        'doc/book/system-administration/security.adoc',
        'doc/book/system-administration/with-chef.adoc',
        'doc/book/system-administration/with-puppet.adoc',

        'doc/book/scaling/index.adoc',

        'doc/book/appendix/index.adoc',
        'doc/book/appendix/advanced-installation.adoc',

        'doc/book/glossary/index.adoc',

        'doc/book/operating/index.adoc',
        'doc/book/operating/backing-up.adoc',
        'doc/book/operating/monitoring.adoc',
        'doc/book/operating/security.adoc',
        'doc/book/operating/with-chef.adoc',
        'doc/book/operating/with-puppet.adoc',

        'doc/book/architecting-for-manageability.adoc',
        'doc/book/architecting-for-scale.adoc',
        'doc/book/hardware-recommendations.adoc',
        'doc/book/pipeline-as-code.adoc',
    );
    
    open my $fh, '>', 'manuscript/part2.md' or die;
    print $fh "{sample: false, id: user-handbook}\n";
    print $fh "# User Handbook #\n\n";
    close $fh;
    print $book "part2.md\n";

    foreach my $source (@files) {
        my $infile = "$path/$source";
        my $filename = $source;
        $filename =~ s{/}{-}g;
        $filename =~ s{adoc$}{md};
        my $outfile = "manuscript/$filename";
        convert_asciidoc_to_markua($infile, $outfile);
        print $book "$filename\n";
    }

    my $filename = 'manuscript/license.md';
    convert_asciidoc_to_markua('../jenkins.io/LICENSE.adoc', $filename);
    print $book "license.md\n";

    close $book;
}

sub convert_asciidoc_to_markua {
    my ($infile, $outfile) = @_;
    my ($id) = $infile =~ m{/([^/]*)/index.adoc$};
    if ($infile =~ /LICENSE.adoc$/) {
        $id = "user-handbook-license";
    }

    my $ap = Asciidoc::Parser->new;
    my $markua = '';
    $markua .= "{id: $id}" if $id;
    my $data = $ap->parse_file($infile);
    for my $e (@{ $data->{content} }) {
        die 'not ref' if not ref $e;
        if ($e->{tag} =~ /^h(\d)$/) {
            my $level = $1;
            $markua .= "\n" if $markua;
            $markua .= '#' x $level;
            $markua .= " $e->{text}\n\n";
            next;
        }

        if ($e->{tag} eq 'code') {
            if ($e->{lang}) {
                $markua .= "{format: $e->{lang}}\n```\n$e->{cont}```\n";
            } else {
                $markua .= "```\n$e->{cont}```\n";
            }
            next;
        }

        if ($e->{tag} eq 'special') {
            if ($e->{lang}) {
                $markua .= "{format: $e->{lang}}\n```\n$e->{cont}```\n";
            } else {
                $markua .= "```\n$e->{cont}```\n";
            }
            next;
        }

        if ($e->{tag} eq 'li') {
            $markua .= handle_row($e, "\n");
            next;
        }

        if ($e->{tag} eq 'p') {
            $markua .= handle_row($e, '');
            $markua .= "\n\n";
            next;
        }
        die "Unhandled tag '$e->{tag}'";
    }
    open my $fh, '>:encoding(utf8)', $outfile or die;
    print $fh $markua;
    close $fh;
    #print Dumper $data;
    #exit;
}

sub handle_row {
    my ($e, $end) = @_;
    my $markua = '';
    foreach my $part (@{ $e->{cont} }) {
        if (ref $part) {
            if ($part->{tag} eq 'b') {
                $markua .= "*$part->{cont}*";
                next;
            }
            if ($part->{tag} eq 'a') {
                if ($part->{link} =~ m{^https?://}) {
                    $markua .= "[$part->{cont}]($part->{link})";
                } else {
                    $part->{link} =~ s{^(\.\.)?/}{};
                    $markua .= "[$part->{cont}](#$part->{link})";
                }
                next;
            }
            die "Unhandled internal tag '$part->{tag}'";
        } else {
            $markua .= $part . $end;
        }
        next;
    }
    return $markua;
}


