## Add Python test {#add-python-test}

Then take the [python-without-test](https://github.com/collab-dev/python-without-test) repository. Write a test, set up Travis, send PR (We will comment on the PR)

* Fork and clone this repository
* Write a test for the `is_anagram` function that you can see in action in the bin/is_anagram.py
* Once tests are running on your system, set up Travis-CI
* Once Travis works in your own GitHub/Travis-CI accounts, send a pull-request.
* We will comment on the PR, but won't merge it.

## Python test coverage

```
python run -m unittest discover
```


```
pip install coverage
```

```
coverage run -m unittest discover
coverage report -m
```

```
Name               Stmts   Miss  Cover   Missing
------------------------------------------------
app/__init__.py        0      0   100%
app/code.py            9      1    89%   10
app/test_code.py      11      0   100%
------------------------------------------------
TOTAL                 20      1    95%
```

We can see that in the app/code.py file where our applications lives only 89% of the statements we covered. Specifically line 10 was not executed during the test run. This provides valuable insights to the code. We can now look at the source code and check why was that line missed. Is it in use at all? If not we can remove it. If it is in use we can think of tests that would execute it.

