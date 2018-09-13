# Source of my Jenkins book

Most of the files are generated from the articles on the Code-Maven site.

## Generate:

Update the `src/changes.md` file.

```
perl -I ../perl-asciidoc/lib/ convert_jenkins_io.pl
perl ../books/convert.pl
perl convert_jenkins_io.pl
```
