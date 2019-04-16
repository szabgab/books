# Pull Request for Code And Talk {#pull-request-for-cat}

If you have not done the first task [sending a Pull-request](#first-pull-request) then please do that first or at least review the steps there.

In the [GitHub repository](https://github.com/szabgab/codeandtalk.com) of [CodeAndTalk](https://codeandtalk.com/) there is a file called `missing_events.md`. It contains the Twitter account of a lot of conferences that are probably not collected yet. At least their twitter account was not in the conference JSON files when the `missing_events.md` was created.

Your task is to pick one of those twitter accounts and add the JSON file of the corresponding conference. Remove the entry from the `missing_events.md` file, and send a PR with those changes.

The conference JSON files are in the data/events/ directory and details about them can be found in the README file of the project.


## The full process


### Setup working directory

* Visit https://github.com/szabgab/codeandtalk.com and click on  *fork* to create a copy of the repository in your GitHub account.
* `git clone my_URL`   - This will opy the git reposiotry to your computer.
* `cd codeandtalk.com` - You need to be in the root directory of the project. Not above it. Not in a subdirectory.
* `git add remote upstream https://github.com/szabgab/codeandtalk.com.git`   This is needed so later you will be able to update your repository from the central repository of the project.

### A cycle of changes:

* `git branch branch-name` where branch-name can be anything, e.g. event1 or event-name-2017 will create a branch that will make all the development process smoother.
* `git checkout branch-name` will switch your working directory to be in the branch.
* `cp data/skeleton-event.json data/events/event-name-2017.json` With the appropriate filename. Edit the JSON file, remove the line from missing_events.md. Best if the they are in the same change, we won't lose the event as the twitter account is mentioned in the JSON file.
* `git add data/events/event-name-2017.json` again, with the appropriate JSON filename.
* `git add missing_events.md` 
* `git commit -m "adding event event-name-2017"`
* `git push` This will complain and offer a new command, do that. 
* Go to github and send a Pull Request.

If it fails the tests you'll need to edit the file again:

* `git checkout event1` The name of the branch you used to add the event. Edit the json file.
* `git add data/events/event-name-2017.json`
* `git commit -m "update data/events/event-name-2017.json"`
* `git push` This time it will not ask for correction as it already remembers it.

When you would like to start a new change-set
* `git checkout main`

Then you start again with `git checkout -b branch_name`

### Update from the central repository

Once in a while, for example every time before you'd like to star a new change-set, you'd better update your reposiotry from the central repository of the project.

* `git checokout main`
* `git pull upstream main`
* `git push`

