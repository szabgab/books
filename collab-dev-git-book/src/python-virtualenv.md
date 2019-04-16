## Virtualenv for Python

To set up a virtual environment in Windows follow these steps:

Run

```
pip install virtualenvwrapper-win
```

Add python to environment Path.

```
C:\Users\<user>\AppData\Roaming\Python\Python36\Scripts
```

Note: If you had a Windows command window open you'll need to open a new one for the path to refresh.

Run mkvirtualenv venv to create a new evnironment called "venv"

Note: you must run this command from a windows command and not from Git Bash.

Go the directory where you want to use the virtual env cd C:\Users\<user>\Documents\GitHub\python-with-test

Then continue with

```
pip install -r requirements.txt
```

