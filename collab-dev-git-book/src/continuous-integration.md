# Continuous Integration - CI {#ci}

In a project where there are multiple developers before we can release the project we need to integrate the changes the various people made. If we really wait till the time when we want to release the project we will likely spend a lot of time trying to integrate the different parts.

Therefore organizations started to create "nightly builds", that would combine the different parts of the project. Today, especially if we are talking about Agile development we need to attempt the integration continuously. That mean every time a core developer pushes a change to the central repository we would like to make sure nothing has broken. Even better, every time a contributor sends in a pull-request, before we even look at it we would like to make sure it does not break anything.

We have already seen this working right at the beginning of our journey. Now we are going to learn how to set up such continuous Integration ourselves.

If I'd like to explain in a nutshell a Continuous Integration (CI) system monitors the Version Control System (VCS) and on specific events it triggers some code that will verify the current status of the project.

This code usually "builds" the project whatever that means in the specific project and then runs the test-cases of the project.

In the [first pull-request](#first-pull-request) the code checked if every line in the CSV file has two columns and if the last entry is Snow White.
In the [second pull-request](#second-pull-request) the code checked if the JSON file is valid.

In a huge project written in the C programming language the code might compile the code and then run thousands of test-cases verifying that the code works as expected.

In this chapter we are going to learn about a number of CI systems and then we are going to use a cloud-based CI system called Travis-CI.

## Various CI systems

There are a number of ready-made CI system. Several of these are Open Source. You can download and install them on one of your computer on premise. There are also a number of cloud-based CI system. In the end each one of these system run the same code to build your application and the same code to test your application. Code that you wrote.

There are some differences in how you can configure each CI system. How you can set up the environment necessary for your build-system and test to work. What might be required to collect and display reports.

The most well-known Open Source CI system are [Jenkins](https://jenkins.io/), [BuildBot](https://buildbot.net/), and [CruiseControl](http://cruisecontrol.sourceforge.net/).

The most well-known cloud-based solutions are [Travis-CI](https://travis-ci.org/) that provides free CI service on Linux and OSX but it is only available for GitHub users. [Appveyor](https://www.appveyor.com/) that runs on MS Windows and [CircleCI](https://circleci.com/) that runs on Linux.

The advantage of the cloud-based solutions is that we don't need to install anything and we don't need to maintain a computer just for the CI.

We are going to focus on Travis-CI.

