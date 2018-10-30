# The source of the Perl Maven eBook

Most of the content is generated from pages stored in the https://github.com/szabgab/perlmaven.com repository,

## Release process


```
git clone https://github.com/szabgab/books.git
mkdir perl-maven-book
cd books/perl-maven-book
```

* Update the src/changes.md file

```
perl ../convert.pl . ../../perl-maven-book/
```

## TODO

* Who links to sites/en/pages/beginner-perl-maven-e-book.txt and what shall we do with that?
* Include exercises and their solutions from the slides?
* File::Slurper (see the rejected pr of Ron Savage 


To include later:

* <a href="https://perlmaven.com/using-the-built-in-debugger-of-perl">basic commands of the built-in debugger of Perl</a>
* <a href="https://perlmaven.com/use-diagnostics-or-splain">using diagnostics or splain</a>
* <a href="https://perlmaven.com/always-use-strict-and-use-warnings">use stict; use warnings;</a>
* <a href="https://perlmaven.com/chomp">chomp</a>
* <a href="https://perlmaven.com/use-path-tiny-to-read-and-write-file">using Path::Tiny</a>
* <a href="https://perlmaven.com/the-default-variable-of-perl">default scalar variable of Perl</a>
* <a href="https://perlmaven.com/unique-values-in-an-array-reference-in-perl">reference to an array</a>
* <a href="https://perlmaven.com/how-to-set-default-values-in-perl">set default value</a>

