# Your second Pull Request {#second-pull-request}

This second Pull request will require a lot more, but still no need to program anything. You only need to be able to use your computer in a reasonable proficiency.

We assume you have already [set up your environment](#setup) and [installed](#install-git) and [configured git](#configure-git) on your local machine, and you also have a [text editor](#install-editor).

I am going to use the `szabgab-demo` account on GitHub for the demonstration. As you read the text you will have to keep in mind to replace that with your own username.

## Fork a repository 

* Visit the GitHub page of the project. [project](https://github.com/collab-dev/participants). This is the full Git repository of the project.
* 'fork' this repository: See the fork button on the GitHub page of the project. Assuming your username on GitHub is foobar, this will create a copy of the whole Git repository in your GitHub account and you'll have a URL: https://github.com/foobar/participants/ 

## Clone a repository

'clone' the forked repository to your local disk.

* Open your terminal or Command Prompt if you are on Windows
* Change to a directory where you'd like to have a subdirectory for the project. e.g. I have a directory called `~/work` and inside I have a directory for each project. So I'd `cd ~/work` and then `git clone https://github.com/foobar/participants.git` 
* On Windows I have a directory called `c:\\work` so I `cd \work` and then run the clone command.
* In both cases it will create a subdirectory called 'participants' and will create a copy of the whole Git repository in that directory on your local machine.

## Create a branch

* Create a branch: `git checkout -b myname`

## Make some changes

* Add yourself to the '''participants.json''' file.
  * `name` and `github user ID` are required fields
  * the rest are optional

## Record the changes {#commit}

You have changed a file now. Before we save the change in the Git repository let's look around.

Run

```
git status
```

this is one of the most common command used in Git. It tells us what is the status of the files in the working directory and what does Git know about them.

TBD. How should it look like.

You can also check if your changes are as expected. Type in

```
git diff
```

and you will get a textual report showing which files were changed. Which lines were added and which were removed. At first the way this is shown might be a bit strange, but soon you will get used to, or you will find a GUI tool to display the changes.

Once you have verified that the changes in the files are indeed what you wanted to make, then you can move the changes to the staging area of Git. In some other version control systems there is no separate staging area. You just commit your changes. At first this staging area will look a bit unnecessary, but when you get more proficient in Git you'll see it is a very powerful feature.

Unfortunately for now you only see its drawbacks.

Add the changed file to the staging area of git:

```
git add participants.json
```

At this point I'd recommend running `git status` again to verify that your staging area looks as expected. I usually do this and when I don't I often regret it.

Once you have verified the content of the staging area you can commit the changes. This basically records the change in the the local Git repository.

Commit the changes:

```
git commit -m "adding my name"
```
the *-m* parameter allows us to provide a commit message. This can be any string. It is usually a good idea to have a clear explanation what have you changed and why. Unless it is really obvious.

If you forget to include the -m flag, git will try to open an editor on your computer. By default this is usually vi on Linux machines. Unless you are already familiar with vi this is not the right time to learn it.

## Push out the changes to GitHub

Push out the changes to your forked repository

```
git push
```

This will give you an error message that looks like this:

```
fatal: The current branch event_branch has no upstream branch.
To push the current branch and set the remote as upstream, use

    git push --set-upstream origin event_branch
```

The problem is that git has a branch locally and it needs to know to which branch in the remote repository to to push your changes to. You could use any branch name there, but the natural choice is to use the same name in the remote repository as you used locally. As you might need to be able to push further changes from the local branch to the remote branch, you'd also like to tell git to record this mapping so in subsequent push commands you won't need to repeat these details.

Luckily the error message includes the command you need to execute to do the mapping and push out the changes. So just copy and paste the above command.

### Troubleshooting

Before the error message above you might actually get another warning:

```
warning: push.default is unset; its implicit value has changed in
Git 2.0 from 'matching' to 'simple'. To squelch this message
and maintain the traditional behavior, use:

  git config --global push.default matching

To squelch this message and adopt the new behavior now, use:

  git config --global push.default simple

When push.default is set to 'matching', git will push local branches
to the remote branches that already exist with the same name.

Since Git 2.0, Git defaults to the more conservative 'simple'
behavior, which only pushes the current branch to the corresponding
remote branch that 'git pull' uses to update the current branch.

See 'git help config' and search for 'push.default' for further information.
(the 'simple' mode was introduced in Git 1.7.11. Use the similar mode
'current' instead of 'simple' if you sometimes use older versions of Git)
```

I think this happens only at certain versions of git. My recommendation is that you run:

```
git config --global push.default simple
```


## Send a Pull-Request

* Send a Pull-request with the changes (on GitHub)

Event though you sent the pull-request you are not done yet. You will be done once your change got accepted and merged into the main line of the project.

## Observe Travis-CI running and reporting

[Travis-CI](#travis-ci) is Continuous Integration service we can use free of charge with public GitHib projects. What this means is that we can add some software to our project and every time the maintainers push out some changes and every time someone sends in a pull-request, Travis-CI will automatically fetch the most recent version of the project (or the project including the Pull-request) and runs that software.

Once the software finished running we get an indication if the software finished successfully or failed to run properly till the end.

In a software project we usually use this to verify if our project works properly and if the most recent change (or the proposed pull-request)
does not break something that worked earlier. In this specific project the only thing we check is whether the JSON file is properly formatted.

We will discuss [Travis-CI](#travis-ci) much more later in the book.

For now what you need to do is to look at the Pull-Request you sent and see if the Travis ran successfully or not. On the page of the Pull-Request you will see a section with Travis-CI and a dot. If the dot is yellow it means Travis is still running the program. If it is green it means success. If it is red it means failure. In this case you should click on the "Details" link and see what is the problem.

Check why not, fix the problem, commit the changes, and push the new changes out to GitHub again.

TBD: Observe how someone sees the PR and how can that person react.

TBD: Wait for the response or if you want, go ahead to the next exercise.

