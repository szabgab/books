## Add test to Perl 5 project {#add-perl5-test}

Check out the [perl5 project](https://github.com/collab-dev/perl5-project), that already has a few test. It has both Travis-CI and Appveyor configured.

Apparently for Perl it is not enough to tell Travis to run `prove -l` we also had to create a rather minimal `Makefile.PL` file so the default process on Travis-CI will work.


Fork the project [perl5-with-test](https://github.com/collab-dev/perl5-with-test), set up Travis-CI and submit a PR from a branch. (We we will comment on the PR)

run `prove -l` to run the test.

Then take the [perl5-without-test](https://github.com/collab-dev/perl5-without-test) repository. Write a test, set up Travis, send PR (We will comment on the PR)

[Appveyor and Perl](http://blogs.perl.org/users/mauke/2017/10/automated-testing-on-windows-with-appveyor.html)

Pick a CPAN module and send a Pull Request for that module.

There are plenty of modules on CPAN, the Comprehensive Perl Archive Network that could be improved  Some don't have any test. Others might have tests, but don't have Travis-CI or Appveyor configured. These are the relatively low hanging fruits as you don't need to get deeply involved in the project and you can already contribute.

Probably the best way to find a module to contribute to is to look at the [recently uploaded modules](https://metacpan.org/recent) and pick one from there. You'll have a much better chance to get the attention of someone who has just uploaded a module than from someone who has not touched anything on CPAN for 2=3 years.

## Test Coverage

Once there are a few tests you can check the coverage of the tests. That is you can check which lines of code in the actual application have been executed during the tests. This can provide a reasonable indication of the security net the tests provide. Any line of code or any condition that is not covered with tests is a potential risk. Unfortunately the opposite is not true. Just because a line of code was executed and returned the correct value in a test case does not mean that it will work properly no matter what are the input values.

Anyway if we can generate a report which lines in the application code are not executed during the tests, we can have a better evaluation of the situation. We can also take some action. If we find a piece of code, especially if it is a full function, that was never executed it can be of two major reason. One is that code is not in use. Maybe it was an old version of a function we have forgotten to delete. Maybe it was a failed attempt to write some code. In these cases we might reach the conclusion that we don't need this code any more. Then we can delete it.

### Generate Test Coverage report {#generate-test-coverage-report}

In order to generate the report we need to install the module called Devel::Cover{i: "Devel::Cover"}.

then we need to run the following commands:

```
perl Makefile.PL
cover -test
```

This will generate a text report that looks like this:

```
---------------------------- ------ ------ ------ ------ ------ ------ ------
File                           stmt   bran   cond    sub    pod   time  total
---------------------------- ------ ------ ------ ------ ------ ------ ------
blib/lib/MyMath.pm             90.9    n/a    n/a   80.0    0.0  100.0   77.7
Total                          90.9    n/a    n/a   80.0    0.0  100.0   77.7
---------------------------- ------ ------ ------ ------ ------ ------ ------

HTML output written to .../perl5-project/cover_db/coverage.html
done.
```

If this was a bigger project with more than one pm files, we'd see one line for every pm file. In each line we see several columns. The `stmt` columns show which percentage of the statements we executed in that file. The `bran` column indicates the percentage of branches that were covered, the `cond` column shows the percentage of conditions covered. Our example is so simple and stupid that there are no branches and conditions in our code. In any case this book is not an in-depth analysis of testing and test coverage. The `sub` column shows the percentage of the subroutines that were covered during the tests. The `pod` column indicates the level of documentation. Not relevant for us.

If we open the html file mentioned at the bottom of the report with our favorite browser we will see a nicer version of the same report:

![Perl 5 Coverage Summary](images/perl5-coverage-summary.png)

We can drill down to see more details in the HTML version.

If we click on the filename `blib/lib/MyMath.pm` we will see the following report:

![MyMath test coverage report](images/perl5-mymat-test-coverage-report.png)

The most interesting for us here is the fact that line 14 has 0 in the `stmt` column and in the `sub`. The former indicates that the statement in line 14 was never executed. The latter indicates that the whole `multiply` function was never called.

Using this information we know that either we should add tests for the `multiply` function, or if we arrive to the conclusion that we actually don't need it, then we can remove it from our code. In either case we improved our code-base.

If you do this to a code-base that you are not familiar with then maybe the correct action is to tell the maintainers about your findings and ask what would they suggest.


* [Perl on Travis-CI](https://docs.travis-ci.com/user/languages/perl/)
* [Perl helpers for Travis-CI](https://github.com/travis-perl/helpers)



