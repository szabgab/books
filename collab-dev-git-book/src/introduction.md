{sample: true}
# Introduction {#introduction}

In the hi-tech world in general and in the Open Source world in particulare, programming or coding seems like the only important thing. Nothing could be further from the truth. There are plenty of other activities one can do. Some of them might be even more valuable than the programming part.

For example you could contribute to an Open Source project by helping other users. You could report bugs or help design features. You could help triage bugs, closing duplicates, verifying the validity of reported bugs etc. You could work on the web site or the UI of the project. There is always a huge need for better documentation and better tutorials. There are probably many other tasks I have missed.

Similar tasks exist in corporations as well, though there might be some artificial separation dividing the various tasks. In Open Source projects the borders among various tasks is much less defined and people often handle multiple tasks.

In any case, one of the main requirements from anyone in the hi-tech world is good communication skills and the ability to cooperate. Even if this is not explicitly emphasized by many organizations.

For most of the tasks mentioned above, especially in Open Source projects we use some kind of a Version Control System (VCS).

So if you'd like to contribute to an Open Source project the first thing you need to learn, if you don't already know it, is using Git and GitHub for version control.

There are plenty of Version Control Systems out there, but the most popular, especially in the Open Source world is Git. It is a stand-alone VCS that you can use on your own computer alone, you can use it internally in your company, or you can use it with one of the cloud-based solution that provides hosting for your Git repository. GitHub is the most popular among those Cloud services. So to be clear: You can use Git on its own and you can use Git together with GitHub.

Version Control Systems in general have a couple of contributions to out life:

* They allow us to experiment with the files we have without the fear of "how do I get back to the previous state".
* They allow us to look at the history of our development to see older versions of our project.
* They allow us to locate the change that introduced a bug even if that was several weeks, months, or even years before we noticed the bug.
* They make it easy to collaborate on the same project.

Let me dwell on the fear-part a bit.

In my experience many people, especially in the corporate environment actually fear the Version Control System itself. That's very unfortunate as VCS are there to help us reduce feat. I found three major contributing factor to the fear.

One of them is lack of training. People who are not familiar with the capabilities of the VCS they are using will be afraid to make mistakes. Some VCS provide a lot less power and thus are easier to learn, some, such as Git, provide a lot more flexibility, but with that comes a longer and probably steeper learning curve.

The second major source of fear is the process a company builds around the tool. In many case the selected VCS is itself has a built-in process, but companies add additional requirements that make the use of the VCS unpleasant. For example the blind insistence of an open and approved "issue" for every change in the VCS will usually make people a lot less interested in refactoring code.

The third source of the fear is the lack of good project management. Using a flexible VCS such as Git might even make this problem worse. The problem arises when several people have to work on the same file. Even worse if they have to work in the same area of the file. When this happens this is usually a problem with project management and/or with the code itself. This should happen rarely. In older and usually proprietary VCS-es people have to lock the files they are working on. Thus if a second person wants to work on the same file she will be blocked. This is not really good as it wastes a lot of time, but people at companies got used to it. In modern VCSes, and especially in Distributed VCS-es such as Git, you never lock a file. You allow multiple people to work on the same files and then expect the second one to finish her were to merge the changes. In well managed and well designed environments where people communicate with each other, this merge is usually very smooth. The problem is if two people work in the same area of the code, then their changes will create a conflict that will have to be resolved manually. This is the part that people fear and I can totally understand them.

The good solution for this is improved communication among the developers (really, you need to talk to each other...), a better compartmentalization of the source code, and better management of tasks.

