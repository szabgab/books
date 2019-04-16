# Update your local Git repository from the central repository of the project. {#update-project}

## What to do if I mess up?

Git is complex. In the following sections and as you use Git more and more, occassionall=y you will mess things up. You will commit to the wrong branch. You will merge instead of rebase etc. The question what to do when you feel you messed up.

*Don't panick!*

Everyone messes up. Beginners might do it more often, but it happens to experts as well.

The primary purpose of every version control system, including git, is to allow you to experiment and to be able to revert to a previous state. Of course when you just starting to learn git you will mess up more than usual and you will not yet know how to get out of the mess. By the end of the book hopefull you'll know a few trick to help you. For now, however, I'd like to suggest a very simple route.

Always work in small increments. Always send Pull-requests after a small amount of work.

When you feel you messed up you can easily start from scratch.

1. Rename the directory that holds the local git repository. (the root directory of the project)
1. Remove the repository from your own GitHub account. (On the GitHub page of the project under your user go to the "Settings" menu item. Scroll down to the "Danger Zone". Click on the button "Delete this repository". Type in the name of the repository. click on "I understand the consequences, delete this repository".
1. Go to the original GitHub page of the project.
1. Fork again.
1. Clone again.
1. For every change-set (feature, bugfix) create a separate branch starting from the default branch that is usually called "master", though in some of my projects it is called "main" and yet in other projects it is called "dev".


An alternative route is

1. Create a copy of the directory that holds the local git repository. (this will make sure your changes are safe).
1. Experiement on the copy using command such as *git reset HEAD~1* to revert the most rencet commit.


## Conflict management

Before we go on contributing to our first real project we'd better practice several other steps in the collaboration process.

Imagine that just as in your [first pull request](#first-pull-request) you have forked a project, cloned it to your own computer, created a branch, started to make changes. Either at this time, or by the time you sent the Pull-request you notice that project itself made some progress. Maybe the maintainers made some changes by themselves or they have accepted the Pull-request of another collaborator. In any case the "central" repository of the project, the one that you forked had made progress.

If you now go ahead and send a Pull-request or even if you have already done so this means that the baseline of your changes have been already surpassed by the project. Even if the changes made in the project do not have a direct impact on your changes, someone will have to integrate your changes into the main repository. The shorter the history between your changes and the "base" of your changes, the easier it is to integrate those changes. In general we would like to reduce the integration work to the minimum. If possible to a click of button.

The reason for that is that usually there are very few maintainers of a project. In small projects usually there is only one. On the other hand there might be many contributors. Spreading the work-load to all the contributors is better than relying on the maintainer who will become the bottleneck. In addition you, the contributor will understand your changes much better than the maintainer so you are usually in a much better position to simplify the integration.

The changes made on the central project and the changes made by you might have some conflict.

For example in one of our project where we were collecting data and recording them in JSON files, we had a set of rules on how those files need to look like. We even had some program that would check all the files. One person started to make changes and before sending the Pull-request he made sure that he followed the rules by verifying that the tests he has in his fork of the repository all pass. Then he sent a pull-request and Travis-CI reported a failure. At first it was baffling, but soon we understood that in the central repository we added another rule. His files did not adhere to this new rule as he was not even aware of the existence of the new rule.

If he left the Pull-request as it is, the maintainer of the project would have to resolve the problem. This would probably not happen. After all the maintainer added the extra rule in order to reduce the need to fix unwanted file formats. So a better approach is for the contributor to update her forked and cloned git repository from the central repository. "rebase" the changes she made to be based on the latest version of the project.  Solve the problems as necessary. Send a new Pull-request.

Another case that happened is when two people have edited the "participants.json" roughly at the same time and have both added themselves to the end of the file. What happened is that both of them forked and cloned the central repository. One of them sent a pull-request. Before I had a chance to look at it and integrate it, the other person has also sent her pull-request. By themselves neither of the contributors had any easy way to notice the arising issue but they both edited the same file in the same place and added different content. This can happen in big projects, but it quite rare. Actually if this happens often in a project you are involved in (Open Source or proprietary) that usually means the files of the project are not split up properly and that there is a lack of communication among the developers. It can, especially within companies, point to a problem in the leadership of the project or the design of the codebase.


In any case, it is usually a good practice to update your own git repository and integrate your changes with those that happened on the central repository. We are going to see several cases now, and you'll practice the "conflict resolution".


## The 4 cases we are going to cover

* In the first case we assume you have forked and cloned the project but have not made any local changes yet.
* In the second case we assume you created a local branch, made some changes, pushed them out to GitHub and they were integrated into the main repository of the project.
* In the third case you made some changes in a local branch but have not pushed it out yet.
* In the 4th case you made changes in the local branch, pushed it out, maybe even sent a Pull-request, but it has not been integrated yet.


## No local changes yet

```
git remote add upstream
git pull origin master
git push
```

## Integrated branch

* The project has a Github repository. e.g. https://github.com/szabgab/codeandtalk.com
* You created a fork e.g. https://github.com/demo/codeandtalk.com   (if your GitHub username is demo)
* You created a copy of the git repository on your own computer by running `git clone git@github.com:demo/codeandtalk.com.git`
* You created a branch (e.g. one called myname) using `git checkout -b myname`
* You made some progress there, you have pushed your changes out to your GitHub account, sent a Pull Request. It was accepted and your changes were merged.

* In the meantime the repository where it all started https://github.com/szabgab/codeandtalk.com has also moved forward. You need to get your clone and your fork up to date with that.

At this point we can assume that if you run `git status` it will tell the there is nothing to do in your repository. `git branch` will show that there are two branches

```
* myname
master
```

First we need to switch to the `master` branch using

```
git checkout main
```

Then we need to map the 'central' GitHub repository to be one of you remote repositories
If you run

```
git remote -v
```

It will list all the remote repositories currently mapped in your local repository.

```
origin  git@github.com:demo/codeandtalk.com.git (fetch)
origin  git@github.com:demo/codeandtalk.com.git (push)
```

This means the repository 'codeandtalk.com' in GitHub in the account of 'demo' is locally called 'origin'. We have two entries as they map the communication to and from the remote repository. Theoretically we could have them point to two different repositories, but that's rarely needed.

The command

```
git remote add upstream https://github.com/szabgab/codeandtalk.com.git
```

will map the codeandtalk.com repository of user szabgab to the name 'upstream'. This is another arbitrary name, but one that is commonly accepted to point to the 'central' repository of a project. I put the word central in quotes because Git does not really have the concept of central repository. It is only a convention that makes the life of the developers easier. It is also accepted to be the official repository of the project.

Running this command again:

```
git remote -v
```

We will see 4 entries:

```
upstream  git@github.com:szabgab/codeandtalk.com.git (fetch)
upstream  git@github.com:szabgab/codeandtalk.com.git (push)
origin  git@github.com:demo/codeandtalk.com.git (fetch)
origin  git@github.com:demo/codeandtalk.com.git (push)
```

Now we can update our local repository from the official repository of the project by executing:

```
git pull upstream main
```

Then we can update our repository in our GitHub account by executing:

```
git push
```

Here we don't need to specify extra information because the 'main' branch in our local repository was already mapped to the 'main' branch of our repository in our GitHub account.


The changes we pulled from upstream and then we pushed out to our origin already contain the content of our branch as it was merged by the author of the project. This means we don't need our development branch any more. We should delete it locally using the following command:

```
git branch -d myname
```

We should also delete the branch from our repository in our GitHub account using:

```
git push origin :myname
```

We are now done. Our changes were integrated. All the progress of the project was brought to our repositories. We can not tackle the next problem.


## Changes that were not pushed out

Update the main branch from upstream:

```
git checkout main
git pull upstream main
git push
```

Then rebase your branch fixing the conflict:

```
git checkout name-of-the-local-branch
git rebase main
```

Git will tell you there is a conflict when you rebase.
You should open the file with your editor, fix the conflict to whatever you think it should look like and then continue the rebase.

## Rebase your local branch and update a PR

Like in the previous case, but after you have finished rebasing the branch, you also need
to push out the new changes to the parallel branch in your GitHub account.

```
git push
```

will fail because you effectively changed the history.

You can use the force:

```
git push --force
```

With this you should be done.

## Delete a branch

Once the pull request has been accepted and merged, delete the branch locally, and delete it also your remote repository. 

```
git branch -d <branchname>
```

Will delete it locally.

```
git push origin :<branchname>
```

Will delete in the remote repository called "origin" which is by default the repository where you have cloned from.

