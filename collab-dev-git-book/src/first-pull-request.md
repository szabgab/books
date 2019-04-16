# Your first Pull Request {#first-pull-request}

In this chapter we will start from the very beginning and bring you to your first Pull-Request. A pull-request in the terminology of GitHub is a request sent to the maintainers of a project asking them to integrate some changes you have made. This is one of the basic units of collaboration. Even though I call it "basic" it requires several steps to create Pull Request.

Actually there are several ways to send a pull-request. If the change is minor, for example fixing a typo in the documentation then there is a simplified way to finish the task. This is usually only good if you make a one-off change to a project. We are going to start with this and in the next chapter we'll see a process that will work for any project for ongoing contributions.

For this first pull-request you don't need to know how to program. You don't even need to install anything on your computer.

The only assumption is that you have created a [GitHub Account](#github-account) for yourself.

## CSV - Comma Separated Values

In this chapter you'll have to edit a CSV file and send a pull-request with the updated file. Before we get into the actual task, let me explain what is a CSV file.

CSV that stands for Comma Separated Values, is a very common file format used for storing tabular data. It is a very primitive version of an Excel spreadsheet.

A CSV file has rows of data in it and each row has several fields. The fields are usually separated by a comma `,` hence the name Comma Separated Values. In some cases the separator is a different character. I have already seen tabular files where the separator was a semi-colon `;`. In other cases it is a pipe-symbol `|` (the vertical line). We still usually call those files CSV and then we might also specify what is the separator. In some cases the separator is a `TAB` character. Files in which TABs are used as separators are also called TSV files that stands for TAB Separated Values.

Here is an example of a CSV file listing the names of the 7 dwarfs in English and in Hungarian. I hope that even if never use GitHub after reading the book, at least knowing their names in Hungarian will serve you well in the future.

In this file each row has exactly two values. This is not a requirement of CSV. In general in a CSV file each row can have as many fields as necessary. However usually each row has the same number of fields and then we can imagine columns in the file. In an Excel file you might be used to have all the boxes of a column one under the other. Here, because the values are not padded with spaces, it is harder to see the actual columns. Nevertheless we can imagine them.

This file is also special a bit in that the first row contains the header of the columns. In some CSV files every row is just data. In other CSV files, like this one, the first row is special and contains the titles of the columns.

![code/dwarfs.csv](code/dwarfs.csv)

CSV files can be a bit more complex as we need to handle spaces in the fields or fields that contain commas or newlines. Dealing with CSV files in general is beyond the scope of the book. We only need to deal with a rather simple one.

## CSV file on GitHub

The first GitHub repository we are going to use is called [edit-csv](https://github.com/collab-dev/edit-csv). It has the file in it with the dwarfs. Our task is to add "Snow White" to the end of the file together with her Hungarian name.

If you follow the link to visit that repository you'll see something like this:

![edit-csv repo](images/edit-csv-before.png)

There are 3 files in this repository: `.travis.yml`, `dwarfs.csv`, and `test.py`. We'll discuss all of them later on, but for now we focus on the `dwarfs.csv` file. If you click on the name of the file you'll see the content in a nicely displayed way. This is GitHub recognizing that we are looking at a CSV file and trying to display the content of it in a readable way.

![edit-csv repo](images/edit-csv-dwarfs.png)

You can now explore the interface a bit. For example you can click on the "Raw" button and see the file as it is on the disk.

The "Blame" button would show the content of the file and who made the last change to each row of the file. In our current case this is not very interesting as only I've edited the file. In a big project where several people contribute it can be very useful to see who changed a specific line and when.

The "History" button will show the revisions of the file. Again, not very interesting in this first repository.

## Edit CSV file on GitHub

Then there are a few icons. The one that is really interesting to us is the one that looks like a pencil. If you hover over it (if you put the mouse on top of it without clicking) then you'll see the following text appear: "Fork this project and edit the file".

Click on that icon.

It will open an editor for you 

![edit-csv repo](images/edit-csv-editor.png)

Now you can type in "Snow White" followed by her Hungarian name. (go ahead, find that name)

Once you are down, scroll down in the browser and find the big green button that says "Propose file change".

![edit-csv repo](images/edit-csv-propose-file-change.png)

You can fill out the title of the proposal and even add some extended text, but for this first Pull Request don't bother with either of those. Just click the green button.

This will save your changes in a copy of the `edit-csv` repository.

It cannot save it in the `collab-dev/edit-csv` repository as you don't have write permission to it. This is great as this means the repository of the project is protected from the mistakes or ill will of everyone else. Only a selected few, in many cases only one person can make changes to the official repository of the project. Everyone else can only propose a change.

So the change you just made was saved in your repository. In our case, as we are working as user `szabgab-demo` it is saved in the newly created `szabgab-demo/edit-csv` repository.

![edit-csv repo](images/edit-csv-comparing-changes.png)

In this picture just under the title `Comparing changes` you can see that the `base fork:` is `collab-dev/edit-csv`, the central repository of the project and to the right of it you can see that the `head fork:` is `szabgab-demo/edit-csv`. (Instead of szabgab-demo you'll see your own username.)

## Send a Pull-Request

Below that you'll see a new green button with the text `Create pull request`. Below that there are more details, but for now press that button. It will offer you another pair of windows to type in some explanation about the change you are proposing.

The earlier description was about the specific change. This one is about the pull-request in general. In this case it seems we have some unnecessary duplication here, but  a single pull-request can contain multiple changes and so in more complex cases it is useful to be able to provide an overall explanation as well. For now leave the defaults and just click on the green button that says `Create pull request`.

![edit-csv repo](images/edit-csv-open-a-pull-request.png)


You will arrive to the page of the Pull Request.

![edit-csv repo](images/edit-csv-pull-request.png)

In this image the URL at the top ends with the number 1 as this was the first pull request ever created for this project. When you create your pull request it will be the first PR for you, but will be different number for the project itself. In the URL you see the number relevant to the project. Not to the person sending the PR.

In any case when you send a Pull-Request, GitHub automatically sends an e-mail to the owner(s) of the project. When I sent the above Pull-Request as user `szabgab-demo` GitHub automatically sent an e-mail to my other self which is the owner of the project.

![Pull Request email](images/edit-csv-pull-request-mail.png)

The most interesting part of it is the link to the pull-request.

