# What is Version Control, Git, and GitHub? {#vcs}

As you work on a project, regardless if it is a programming project or an essay comparing the flight patterns of birds with the songs they sing, you will arrive to a point where you would like to put your work aside and mark it as the "first version" or "first edition". Even if it is just a draft. Then as you make progress you will want to put aside the second version and then the third, etc.

One reason you'll want to do this is so if you send a copy to someone and if that someone returns some comments a week or two later you'll be able to go back to the state of your project as it was back then.

You might also want to create these version just before making major changes to your code or text or whatever you are creating. That way, even if you major change turns out to be a bad idea you can easily go back to the previous state of the project that was still good.

## Manual VCS

The easiest way to keep versions of your project is to have a separate directory for your versions in which you have subdirectories numbered 1, 2, 3, or subdirectories that reflect the date they were created. e.g. 2017-09-03 and 2017-09-10. Then before every major change you can copy the whole project into a new subdirectory of your "VCS". It is easy to make these copies, but there is a lot of waste. You copy all the files of the project every time even if only a few of them changed. It is also a bit difficult to compare versions.

A lot more problems arise if more than one people work on the same project. Then in addition to handling the versions, you also need to find a agreed upon way to share the files with each other.
You will also have to be extremely careful not to change the same file at the same time because merging those changes together will be very difficult.

Finally, why would we want to reinvent the wheel?

## Version Control Systems

A Version Control System, or in short a VCS, makes it easy to track the history of one or more files used in a project. It makes it easy to compare the different versions throughout the history of the project. It makes it easy to revert the project to some earlier stage. A good Version Control System also makes parallel development of multiple features by the same developer, or even by several developers easy. VCS-es are usually capable to handle any type of file. They usually provide all their features for plain text files, and a limited set of features for binary files such as images, music, and video files.

Git is the most popular Version Control System, and GitHub is the most popular cloud-based service hosting Git repositories.

