# AdventureChannel

AdventureChannel is an IRC bot that entertains social channels with a turn-based RPG adventure game.  

## How the Game Works

Check out the [gameplay manual](docs/GAMEPLAY_MANUAL.md)

## Contribution Quick Start

1. Fork this repo to your github account
1. Chat with me or look through the `/spec/adventure_game` files to look for tests that haven't been written that look fun, or come up with a new feature that's inline with [the project's philosophy](docs/PROJECT_PHILOSOPHY.md)
1. Make sure no one else has claimed that by scanning the issues
1. do `git checkout -b name-of-feature`
1. Commence hacking


## Project Philosophy

 See the project's [philosophy](docs/PROJECT_PHILOSOPHY.md) manual to get a picture of what direction this project is headed.

## The Contribution Process

Basically, to contribute, you can totally just wing it ;)  

However if you're a perfectionist and want to make sure you're doing things in the 100% smoothest possible way, take a peak at [The Contribution Process](docs/CONTRIBUTION_PROCESS.md).  

## Development

This app is being developed using a loose TDD methodology.  Not only must all PRs come in with, at a minimum, requests for help writing a test to test a feature or unit of code, but actually testing the app conventionally simply isn't feasible because it's too time consuming to manually set up the game state by running commands in IRC.  If you've never done TDD, we might wanna touch base before you get started.

### Basic Dev Environment

#### Ruby and App Stuff
To setup your basic Ruby development environment, you'll just need to...

1. Install Ruby (I recommend installing ruby with [RVM](https://rvm.io/rvm/install) )
1. Make sure ruby came with the bundler gem automatically `gem install bundler`
1. `cd` into the root of this project and install it's dependencies with `bunder install`
1. Do `cp config/application.yml.example config/application.yml` and check the configuration file
1. Test that things work by running the test suite `rspec spec/` (you should get friendly error messages about it not finding an IRC server or Redis, we'll get to that next)


#### Server Stuff
Next you'll need to get the application dependencies installed.  

1.  Get Redis database online in some way [Redis Installation Instructinos](http://redis.io/download) page
1.  Get access to an IRC server and channel (ideally a locally running irc server, `apt-get install ngircd`)

If you have docker installed on your dev machine, bringing up a solid local "staging" environment is as easy as running...

```
$ make boot-containers-dependency
```

The containers booted from this command are source readable it [thenotary/ircd-docker](https://github.com/thenotary/ircd-docker) and [library/redis](https://hub.docker.com/_/redis/).  Check the `Makefile` in this repo to see what docker commands are being run.  


## Testing Advice

Using test driven development when hacking on this app will save lots of time.  In TDD you shouldn't need to manually boot up the app to check how a change you made to the code effects its outputs, rather you run `rake` and check how your change effects the outputs.  You'll most likely need to write your own test or expand existing pending tests to hack on the feature you've taken an interest in.  

e.g. the below pending test...

```
it "should do a thing that was once considered but no one had time to implement"
```

Might become...

```
it "should do a thing that was once considered but no one had time to implement" do
  # This kind of puts a break point in your code so you can try running commands
  # It's indispensable in the ruby world and it along with unit tests is the
  # reason we don't bother with code debuggers
  binding.pry
  expect($Game.thing_that_was_considered).to eq :it_returned_this_expected_symbol
end
```

When tests fail, at the bottom of the screen, it prints the command to run specifically that test.  Try not to make changes in other parts of the code that cause other tests to break unless it's clear that it's a good idea (the other tests seemed like stubs) or you've created an issue to bring up some insufficiencies of what may have actually been intended design (it may well have been an oversight).  

To run all the tests, you need to at least run an IRC server locally and have config/application.yml configured correctly to connect to it.  Theoretically you could use a remote IRC server, but as a rule, tests shouldn't need to use the network except in very narrow cases where you're testing compliance with a network service.  If no IRC server can be connected to, then the IRC based tests will be skipped.  A redisDB server will be required for additional tests.  

You can run `./bin/launch` or `./bin/console` to play around with things too.  But ideally you'll just create a new test for the feature you're working on.  


## Deploy/ Installation

See [Deployment](docs/DEPLOYMENT.md).


## License

GNU AGPL v3
