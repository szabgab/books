# Tools and files to generate my [eBooks](https://leanpub.com/u/szabgab)


* [Ansible](ansible-book/)
* Bailador
* [Collaborative development with Git and GitHub](collab-dev-git-book/)
* [Groovy book](groovy-book/)
* [Jenkins book](jenkins-book/)
* Markua by Example
* [Markua Parser](markua-parser-in-perl5/)
* [Perl Maven](perl-maven-book/)
* Single Page Application with Perl Dancer
* [1000 Python Examples](python-book)

* [JSON in Rust](json-in-rust/)


How to generate: see the README file in each one of the subdirectories.


```
mdbook2leanpub ../rust.code-maven.com/books/json/ ../json-in-rust-generated-book/
```

## Markua for Leanpub

Directory layout

```
manuscript/
  resources/
    title_page.png
    img/
    examples/
  Book.txt
  *.md
```
