Cucumber-Watir Test Harness
===========================

This is a test harness for automated functional testing of web applications, using the [Cucumber](http://cukes.info/) and [Watir Webdriver](http://watirwebdriver.com/) test frameworks. It can be used to support Behavioral Driven Design (BDD) or just automated functional testing of arbitrary web applications.

By using this collection of frameworks, you can quickly start a suite of functional tests for an application using a basic vocabulary inspired by tests that have been used successfully on many production projects.

Tools Used:
-----------

1. Watir-Webdriver
2. webdriver-user-agent
3. cucumber
4. chromedriver

Steps To Install:
-----------------

#### Install the bundler gem

		gem install bundler --no-ri --no-rdoc

#### Install necessary gems using bundler

		bundle install

Running tests
-------------

You can run the tests directly with the cucumber command, or with a set of preset command line options using the `rake` command.

### Run cucumber directly

To run tests directly using Cucumber, simply issue the command:

		cucumber

The above command runs all the tests inside the feature folder but that is not what you want sometimes. To run single individual tests you have to specify the line numbers as below:.

		cucumber features/main.feature:217

This will run the test scenario at line number 217 in the file `features/main.feature`.

### Run cucumber using `rake`

Rake uses tasks to collect a set of functions and commands. In this project, it is used to run cucumber with command line options suitable for testing out different groups of tagged features or

To see a list of tasks, run:

		rake -T

To run the whole regression suite, run:

		rake all

An HTML report will be saved to the `results` folder with screenshots of any failures.
