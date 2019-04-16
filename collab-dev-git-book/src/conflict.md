# Merge and Conflict {#conflict}

When several people work on the same code base more than one people will make changes to the codebase at the same time. Actually this "same time" does not even have to be in the same second or same hour. It is enough that the their development time overlap. That already means that when the second person tries to push out her changes, the central project might have already change. It can also happen that when the maintainers of the project try to merge the second set of changes that will have a conflict with the previous changes.

There are several different types of conflicts. One is much easier to spot, but I think that's what people actually fear the most.
The other one is more subtle. It won't be obvious at first and therefore it is more dangerous to the project.

## Version Conflict

When two developers have made progress in the same project.
If they worked in different files or different areas of the same files then merging the changes will be automatic. This is usually not called a conflict, but it can actually create a Type 2 conflict.

## File Name collision

When two people create files with identical names in identical directories. The extreme case of this is when we have 2 files whose names only differ in case. They are considered different files on Linux and most Unix systems, but MS Windows and Mac OSX have case insensitive filesystems and thus they will regard "abc.txt" and "ABC.txt" to be the same file.


## Type 1 conflict

The first type of conflict happens when two people work in the same area of the same file. For example if we have a default value in some code base:

```
default = 42
```

and then two people, for whatever reason, change that default to some different number. One would change it to

```
default = 23
```

the other one to

```
default = 19
```

Clearly this cannot be accepted in the end result. The developers will have to talk to each other. Figure out what is the number they want there and use that.


## Type 2 conflict

Imagine you have 3 files. `library`, `use_a`, and `use_b`. 
`library` declares a number of function that both use-files can use. 

Before the changes there is a function called `do_something` declared in `library` that expects 2 parameters.
The function is used in the `use_a` file, but it not used in the `use_b` file.

Developer A notices that she needs to pass another parameter to the function. So she makes the changes in both `library` and `use_a`
and sends in her changes.

In the meantime Developer B wants to use the `do_something` function in `use_b` and so she adds a call to `do_something` with 2 parameters as it is expected by the function.

Both changes are good on their own. There is no Type-1 conflict between the changes as the developers have made changes in different file. Every version control system, including Git, will happily merge both changes without batting an eyelid. Yet the end results won't work properly. In some stricter language the compiler will notice this problem, but some other languages will let this pass. They will simply work incorrectly.

## Type 2 conflict - another case

A better example for the type-2 conflict might be changes to what the `do_something` function actually does. If developer A makes some changes to what `do_something` does then probably no language compile will be able to notice this problem. The code added by developer B will just work incorrectly once it is merged with the changes of Developer A.

## Solution to the Type 2 conflict

The best solution to the type-2 conflict is to have extensive unit, integration, and acceptance tests and to run them frequently, probably using a Continuous Integration system. This won't avoid the problem, but it will help notice the problem. The sooner the better.

## Prevention of Type 2 conflicts

Noticing the conflict is great, but if we can prevent it that's even better. The only good way I know to try to prevent such problems is to talk to each other. Good old human-to-human communication.

## Conflict resolution

There is a rather nasty case of conflict that unfortunately can easily happen in our simple example where we ask our readers to add their name and GitHub user id to a single JSON file. This can easily create a type-1 conflict as more than one readers will add their name to the end of the file. 


The simple case:

* Both Stranger and You forked the project at about the same time.
* Stranger sends in her changes. There is no conflict as she just added some changes to the end of the file. We merge it.
* You send in your changes. GitHub indicates a conflict as these changes are supposed to go to the end of the file.

Assuming you made the changes in a branch, you can update the main (or master) branch from upstream. Then you can switch to your branch, rebase it onto main (or master). During the rebase it will probably complain about the conflict. Then you have a chance to edit the file and fix the complain. Then you can run `git rebase --continue`

```
git checkout master
git remote add upstream http:/...
git pull upstream master
git push
git checkout mybranch
git rebase master

   You will need to resolve the conflict here
git rebase --continue

git push --force
```

The nastier case.

* Both Stranger and You forked the project at about the same time.
* You send in your changes. There is no conflict. 
* Stranger sends in her changes. There is no conflict as we did not have the time to merge the changes you sent us.
* We have time, merge the changes of Stranger. (Don't ask. These kind of out of order merging can happen all the time.)
* Then GitHub will indicate that there is a conflict between your changes and the code in the central repository.

This is even nastier than earlier. You were the first. GitHub said everything is fine and then 2 days later suddenly it is not fine.

Luckily the solution is the same as in the previous case. 

## Type 3 conflict

This will probably only happen if you work on your own project.

When you try to push to a repository you cannot do that as someone has already pushed a new version. This can easily happen if more than one person has write access to the repository, but also if you work alone on a project. You might have made some local changes and local commits, but before you push your changes out to your GitHub account you accept a Pull-request from someone else. This PR will create a change on your repository in Github that is not yet reflected in your local copy.

Before you can push out your changes you need to update the local repository.  You can do this using either `git pull` in which case a merge will happen and you'll have a dimond in your development history. You can also use `git pull --rebase`. With this command Git will take remote changes bring it to your local repository and it will take your local changes and place them *after* the remote changes. Effectively it will look as if the remote changes came first and then your local changes were applied.


