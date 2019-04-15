# Source of my Ansible book

## Release process

```
git clone https://github.com/szabgab/books.git

mkdir ansible-book-generated
# or
git clone git@github.com:szabgab/ansible-book-generated.git

cd books/ansible-book
```

Update the `src/changes.md` file.

```
perl ../convert.pl . ../../ansible-book-generated --relax
```

This will generate the Markua files that are then uploaded to Leanpub that generates the book.

