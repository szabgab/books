## Configure Git client {#configure-git}

Git has several clients that are more graphical, but in the end they all use the underlying commands. Later, after you have understood the necessary operations of Git you can switch to such GUI-base Git client, though I think by the time you learn this you will not want to.

### Configure your name and e-mail on your local computer

Git has plenty of configuration options, but two are required. Git needs to know what name and e-mail address to use when it records your work. I'd recommend using your own name and your own personal e-mail address, but please check the discussion about [privacy](#privacy) before you decide.

The following command will set your name to be "Foo Bar".

```
$ git config --global user.name "Foo Bar"
```

the following command will set the email address to be "foobar@example.com".

```
$ git config --global user.email "foobar@example.com"
```

The following command will list all the global configuration values:

```
$ git config --global --list
```

This is enough to get you started and you can now jump ahead to select and [editor](#install-editor) or if you are interested you can keep reading and make more customization for your Git client. If you jump ahead make sure to come back later on and read this part as well.

### Git Aliases

All the git commands start with the word `git` followed by various commands and parameters. Some of these are used more often than the others. If there is a command that we use often that consists of many characters we can opt to create an `alias`, a shorter name for it and then use that.

Probably the most basic and most frequently used command in Git is the `git status` command. Later on we will explain the meaning and the usage of each one of these commands, for now let's focus just on the name. Some people who would like to avoid typing this command again and again create an alias called `st` so they can type `git st` instead of `git status`. It is probably a very small gain, but it is simple one to show the `alias` functionality. You can run the following command:

```
git config --global alias.st status
```

That will tell git that from now on typing `git st` is an alias for `git status` and it should treat the shorter command exactly as it does with the longer one.

There is a command called `git checkout` that some people shorten to `git co`. You can do that by running

```
git config --global alias.co checkout
```

Another frequently used command is `git commit`. We cannot shorten it to `git co` as that's already taken. People who arrive from other version control system are used to a similar command called `checkin` so some people create an alias

```
git config --global alias.ci commit 
```

mapping `git ci` to `git commit`.

All of these gave little gain in the length of characters, the following two are better.

The `git log` command allows use to see the history of project. It can get tons of parameters that help us visualize the history in different ways. For example the `--name-only` flag will show the names of the files that change in every changeset. I have this mapped to the `git files` command with:

```
git config --global alias.files "log --name-only"
```

Another set of parameters I copied from some other people is the the following mapping:

```
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
```

This provides a very nice output. We'll try them later.

### Git configuration file

Just as an aside I mention that the global configuration options are recorded in a file called `.gitconfig` in the home directory. In Linux and OSX this means you can access the file as `~/.gitconfig`. On Windows TBD. So you don't really need to run several `git config --global ...` commands. You can just edit that file using any text editor.

### Set Notepad++ as the default editor

In the `core` section and a line setting the editor:

```
[core]
editor=\"c:/program files (x86)/Notepad++/notepad++.exe\" -multiInst -nosession]
```

