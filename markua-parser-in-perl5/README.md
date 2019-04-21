# Markua Parser in Perl 5 eBook files


## Publish

* Update the src/changes.md
* Generated the md files:

```
perl ../books/convert.pl
```


## Release process

```
git clone https://github.com/szabgab/books.git

mkdir markua-parser-in-perl5-book-generated
# or
git clone git@github.com:szabgab/markua-parser-in-perl5-book-generated.git

cd books/markua-parser-in-perl5
```

Update the `src/changes.md` file.

```
perl ../convert.pl . ../../markua-parser-in-perl5-book-generated --relax
```

This will generate the Markua files that are then uploaded to Leanpub that generates the book.

