# Source of my Jenkins book

Most of the files are generated from the articles on the Code-Maven site and from the Jenkins Manual.

## Generate:

```
git clone https://github.com/jenkins-infra/jenkins.io.git
git clone https://github.com/szabgab/perl-asciidoc.git
git clone https://github.com/szabgab/books.git

mkdir jenkins-book-generated

# or

git clone git@github.com:szabgab/jenkins-book-generated.git

cd books/jenkins-book
```

Update the `src/changes.md` file.

```
perl -I ../../perl-asciidoc/lib/ convert_jenkins_io.pl ../../jenkins-book-generated/
```
