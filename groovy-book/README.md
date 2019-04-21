# The source of the Groovy eBook

## Release process

```
git clone https://github.com/szabgab/books.git

mkdir groovy-book-generated
# or
git clone git@github.com:szabgab/groovy-book-generated.git

cd books/groovy-book
```

Update the src/changes.md file

```
./generate.sh
```

This will generate the Markua files that are then uploaded to Leanpub that generates the book.

