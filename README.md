# GuysFitnessApp

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/GuysFitnessApp`. To experiment with that code, run `bin/console` for an interactive prompt.

GuysFitnessApp is a terminal app that allows multiple people to store and view their workout data. The data that is viewed is competely unique to the user and won't affect anyone else. The app also allows for you to set a default user by using a command line flag, see usage below. This is for users who are on their personal computer so they don't have to worry about other people using their login and do not want to spend the time to log in every time.


## Links
[Github] https://Github.com/Guy-Norkunas/GuysFitnessApp

## Description

When a user makes an account they are given a unique login id which is made from running their username and password concatenated together and ran through a hashing function. This loginid is used to store the users data uniquely. The way users are stored is in a csv file titled users that holds usernames and login ids, this allows the program to check a certain username against a certain login id when a password is provided. 

Once logged in the user needs some data, all data in this program is stored as a csv and every csv that holds data is unique to each user, this is done by making a new csv on account creation that is automatically given a header that is used in the program. Once the user has data, viewing, adding, and removing data is simple.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'GuysFitnessApp'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install GuysFitnessApp

## Usage

Once you run the app you're met with a login screen, if you don't have a login already simply just select sign up and you will be prompted to type in your desired username and password.

Now that you're signed in you can begin to use the program. If you select "view exercises" you are given a list of options to choose from, these are the names of exercises that you have already recorded, you will access the data about a certain exercise by typing in the name of it. Obviously if you have just made an account you won't have any data associated with your login id. 

You're other options are to add and remove data. Removal is done by selecting an exercise from the optins that you are given and then selecting the date that the specific exercise you wanna delete occurs. Adding on the other hand you simply fill out all the info when prompted, date, exercise name, working weight and sets.

The program also has some command line features built in:

  "set-default" - prompts the user to login or signup after which if its successful that user is then set to the default user

  "remove-default" - removes the current user as the default user, meaning that that account can no longer be accessed without the use of a password

  "default" - if available, logs in as whoever is currently set to the default user

When you want to exit the program just select exit program in the main menu and the program will give you a farewell and then exit.

## Features

Login system:
Has a login system with unique usernames. The users password are not saved in plain text and so it has some security to it. Instead the username and password combinations are checked by creating a loginid that is simply the combination of username and password ran through a hash function.

Cool looking menus:
All menus in GuysFitnessApp are made usuing tty-prompt, this achieves two things, it helps to control user input as well as improving the presentation of the program. The main menu also runs in a while loop so the program will run until the user decides to select the exit option (or ctrl+c).

Command line arguments:
GuysFitnessApp can take an argument off the command line in order to skip the login process and in a way stay logged in as a specified user. This improves user experience.

Unique users:
GuysFitnessApp allows for many users to use a single system and all store their data indpendently of one another, that way one person is not able to alter the recorded data of another person. It also improves reading and writing time when a lot of users is involved.

Persistent data:
All workout data saved within GuysFitnessApp is persistent so users inputting their exercises don't have to worry about closing the program and will be able to access their data just the same as they input it next time they run the application and log in with the same credentials.


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Guy-Norkunas/GuysFitnessApp. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/Guy-Norkunas/GuysFitnessApp/blob/master/CODE_OF_CONDUCT.md).


## Code of Conduct

Everyone interacting in the GuysFitnessApp project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/Guy-Norkunas/GuysFitnessApp/blob/master/CODE_OF_CONDUCT.md).
