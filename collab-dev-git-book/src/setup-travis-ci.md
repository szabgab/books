## Set up Travis-CI {#set-up-travis-ci}

In this section we are going to look at a very minimalistic GitHub repository with a very simple Python project in it. The project already has a unit-test. We are going to learn how to set up Travis-CI to make sure the tests are running every time we push code out to the repository, and every time someone sends a Pull-Request.

As we cannot set up Travis-CI for the repository for someone else we'll need to "fork" the project. Set up Travis-CI for the copy of the project under our GitHub user. Then, once the Travis-CI setup works, if we would like to, we can send a Pull-Request to the original author of the project so s/he can integrate the changes.

First you need to "fork" the project [python-with-test](https://github.com/collab-dev/python-with-test) so you'll have a copy in your GitHub account.

Then you need to "clone" the project. That will copy the whole repository to your local disk.

This is the layout of the project:

```
.
├── README.md
└── my
    ├── __init__.py
    ├── math.py
    └── test_math.py
```

Here `my` is just the name of the project.  `math.py` contains our "application" and `test_math.py` contains the unittest for our application.

Before we try to get Travis to run our tests, we need to verify that we can run the tests on our local machine. A well maintained open source project will have some explanation in its README file on how to run the tests. Big projects might have a separate file describing this. Usually called DEVELOPMENT. Other projects might rely on the assumption that people experienced in the specific programming language will know the standard ways (there seem to be always several standards) to run the test. Yet other projects will assume you can figure it out.

A> As an aside I'd say that if the particular project does not have clear instructions on how to run the tests, you might consider
A> adding this information to the README file and send that as a separate Pull-Request.

In our repository there are no instructions. After all the book needs to be useful for something.

This project is written in Python and we use the [unittest](https://docs.python.org/3/library/unittest.html) library to write our tests. There are other libraries that would be more suitable to write tests, but the `unittest` library comes built-in Python and for our purposes it is better that we don't need to install anything.

A> If you are not familiar with Python, don't worry. You'll learn it fast.
A> In addition, in case you are not interested in learning Python, we are going to have similar examples in a number of other languages.
A> If the examples don't exist in your preferred language, please [let me know](#feedback).

Here is how you run the unittests in Python. First of all make sure you are in the directory of the project. (Most likely called python-with-test.)

```
$ python -m unittest discover
```

This command runs Python. The `-m` flag tells Python to load the `unittest` module and then the word `discover` is already a parameter for the `unittest` module. It tell the module to search through the current directory tree. Locate any files that look like tests (hint: they are called `test_someting.py`), look if there are test cases in the files, and then run the test cases.

You should see an error like this:

```
.F
======================================================================
FAIL: test_sum (my.test_math.TestMy)
----------------------------------------------------------------------
Traceback (most recent call last):
  File ".../python-with-test/my/test_math.py", line 9, in test_sum
    self.assertEqual(my.math.sum(2, 3, 4), 6)
AssertionError: 9 != 6

----------------------------------------------------------------------
Ran 2 tests in 0.000s

FAILED (failures=1)
```

This output means that unittest found 2 test cases. The first one, represented by the dot (`.`) at the top was successful, the second one, represented by F at the top failed. Further down we can see the specific assertion that failed. It says: `9 != 6`.

Having a failing test in the project is bad, but for now we leave it like that. Before fixing it we are going to set up Continuous Integration with Travis, see how the test fails on Travis as well. Then we will fix the test locally and see how Travis will start to pass as well.

### Troubleshooting unittest

If you see results like this:

```
----------------------------------------------------------------------
Ran 0 tests in 0.000s

OK
```

this means `unittest` could not find any tests. Have you changed directory to the directory of the project?


### Configure Travis-CI

Visit [Travis-CI](https://travis-ci.org/) using the same browser that is already logged in to GitHub.

![Travis-CI front page](images/travis-front-page.png)

Click on the "Sign in with GitHub" button located in the top-right corner.

![Travis GitHub authentication](images/travis-github-authentication.png)

Check the rights Travis asks from GitHub. If you accept it, then click on "Authorize travis-ci" button.

After a few redirects it will take you to the "First sync" URL that will look like this (though they have several logos showing randomly)

Email: "Welcome to Travis CI"

Hopefully the image you will see there is not going to be mine either.

If I remeber correctly it is either taken from your GitHub account or from the Gravatar profile of your e-mail. Anyway, that's not very important now.

What is important is that you can click on your user-name (or real name if that's what appears there) in the top right corner and see a short menu:

![Travis account menu](images/travis-account-menu.png)

Click on "Accounts" and you will see your Travis account and the list of all the public projects in your GitHub account.

![Travis first sync](images/travis-first-sync.png)

I saw this list:

![Travis account list](images/travis-account-list-missing.png)

So I have to admit apparently I have not followed my own instructions and have not forked the python-with-test repository before I registered at Travis. This is not bad as it gives me the opportunity to show you another feature that will be useful for you to know in the future, or in case you encounter similar problem.

So at this point I had to back to the [python-with-test](https://github.com/collab-dev/python-with-test) project and click on the "Fork" button in the top right corner of this page:

![Forking python-with-test](images/python-with-test-forking.png)

![After Forking python-with-test](images/python-with-test-after-forking.png)

At this point we can switch back to Travis-CI and go to our "Accounts", but it will still not list the "python-with-test" project. We need to click on the "Sync account" button to ask Travis-CI to get the current list of projects from GitHub and update the list of projects in Travis. You might also need to refresh the web page to see the changes.

Now we already have both projects listed: 

![Travis account list](images/travis-account-list-synced.png)

Next to the name of each project there is a toggle that currently shows and X in grey background.

![Travis toggle before](images/travis-toggle-before.png)

You need to click on the toggle to flip it on. It will look like this once you have turned on Travis-CI for the "python-with-test" project in your account. (My account is called "szabgab-demo", that's what you see there as a prefix.)

![Travis toggle after](images/travis-toggle-after.png)

Now that Travis-CI was enabled for this project, every time we push out a change to GitHub, Travis-CI will notice it, fetch the new version of our code and read the Travis Configuration file to know what to do. Let's now add the Travis configuration file.

### Create the Travis configuration file

Travis expects a file called `.travis.yml` in the root of the project to tell everything Travis needs to know verify your application. (Note the leading dot in the filename. It is used because it indicates "hidden files" in Unix/Linux.) We are going to add that file now.

This file is YAML format which is a user-readable format that is often use for configuration files. It allows us to include key-value pairs (like hashes, dictionaries, associative arrays, or any way you call them) and ordered list (also knows as arrays in some languages.)

The `.travis.yml` file at a minimum needs to declare the language our project is in. Based on that it will know what kind of Virtual Machine to spin up. You can also declare which versions of the language you'd like to use, what kind of environment variables to set and what commands to run on the test machine.

The "test code" can be as simple as reading a JSON file and verifying it is a properly formatted JSON file, or it can use databases and web servers and lots of other tools to verify that your whole project still works correctly. It all depends on the developers. We have a sample [Python project](https://github.com/collab-dev/python-project) that has a simple Travis configuration file, but the [Travis documentation](https://docs.travis-ci.com/) will help you configure your future projects with a lot more parameters.

The `script` part must be the command we use to run the tests. In our case this is `python -m unittest discover`.

So now you need to create your own `.travis.yml` file which can be a copy from the Python projects listed above. Remember, however that every time you want to make changes to a project in Git, create a branch. Work in that branch and send your PR from that branch! In this case you might want to creta a branch called "travis":

```
git checkout -b travis
```

Then you add it to your local repository and push it out to GitHub.

```
git add .travis.yml
git commit -m "addint Travis configuration"
git push
```

Starting with this push, and every push from now on will trigger Travis-CI to launch one or more Virtual Servers for the project and follow the rest of the instructions.

As the tests failed on our local system, we can expect that they will also fail on the Virtual Machine created by Travis. Travis usually send an e-mail every time the tests fail and also when the tests succeed for the first time after one or more failures.

Now that we see Travis-CI works for this project in our GitHub account, let's make sure the tests actually pass.

Every time there is a test failure it can be either because the application we are testing works incorrectly or that the tests are broken. Before you jump the gun and ask, how do we test our test, let me point out that the tests are usually much more simple than the application code so this is usually not relevant.

In our made-up case one of the tests cases simple had an incorrect expectation. I've added it just so I can easily demonstrate a test failure.

### Fix the tests

Open the `my/test_math.py` file with your favorite [text editor](#install-editor).

Find the incorrect test function, that one that tries to verify if the sum of 2, 3, and 4 is indeed 6.
Change the expected value to the what we should really expect. ( Hint: 2+3+4 = 9 ) ☺️  and run the tests again.

```
$ python -m unittest discover
```

This time you should see something like this:

```
..
----------------------------------------------------------------------
Ran 2 tests in 0.000s

OK
```

### Send a Pull Request

Once Travis works in your own GitHub/Travis-CI accounts, send a pull-request. In the pull-request you might want to include a note along these lines:

A> Hi,
A> this PR includes the configuration file to Travis-CI. In order to use it first please visit https://travis-ci.org/
A> sign up with your GitHub user account if you have not done it yet.
A> Click on "Accounts" under your name and switch the toggle next to the name of this repository.
A> When you accept the PR and every time you push out a new change Travis will pick up the changes
A> and run the tests.
A> Enjoy!

We will comment on the PR, but won't merge it so other people will also have the original repository to work on.


### Conclusion

With this you set up Travis-CI for the first time enabling Continuous Integration. You can now jump ahead and [add Travis to a Python project](#python-project) that already has some test or you can read on, learn how to add tests to a Python project that does not even have tests and then go on finding your first real Python project.

