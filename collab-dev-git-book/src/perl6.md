# Perl 6 {#perl6}

The [perl6-project](https://github.com/collab-dev/perl6-project) provides a simple example of a Perl 6 module in the `lib` director, a test file in the `t` directory. We also need to add a `META6.json` that describes the project. It is needed both by the Perl 6 ecosystem and by `zef` the tool we use to install additional modules.

The `.travis.yml` file contains a basic configuration to run the tests on Travis-CI.

The `.appveyor.yml` file contains the configuration needed for Appveyor.


## Tasks

On the official list of the [Perl 6 modules](http://modules.perl6.org/), next to each module you can find a small icon indicating for both Travis-CI and Appveyor if they are set up for this project and what is their status. If you are interested in contributing to a Perl 6 project, adding tests, setting up CI and making sure the module works both on Linux and on Windows is a great help.

