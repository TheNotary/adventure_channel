# AdventureChannel

AdventureChannel hosts an IRC bot that allows you to play a game.  

## Installation

Either push this repo to a PaaS like dokku/ heroku... or...

Install it as a CLI Gem:

    $ gem install adventure_channel

## Usage

To play, periodically, some group of monsters will attack the channel.  
It will be up to members of that channel to fight off the monsters.
Use teamwork and be nice to each other.

When a monster shows up, you must fight it off.  

```
~ A monster has appeared ~
> lvl 2 green goblin
```

### Gameplay Commands

#### !s | !stat

Get status of the adventure:

```
~ The party is in Dungeon: The Disaster Den of Dart ~
~
~ A [lvl 2 green goblin {gg1}] appeared 2 minutes ago ~
> No one has helped fend it off yet!
> It's stealing things from the channel coffer.
```


### Battle Commands

#### !j | !join

Type !j to join the battle, this command will likely be deprecated since joining
the battle can be inferred by performing game acts.  

```
```

#### !r | !run

Leaves the battle (you coward!).  

#### !f | !fight

Use your equipped weapons to fight the assailing monster.  You can specify which monster you'd like to target if you'd like.  

```
  !fight gg1
```

#### !s | !specail_ability

Use the special ability of your equipped weapon if it has one.  

#### !m | !magic

Attack a mob with magic.  

```
  !magic fire
```

#### !spells

List your magic spells.  

#### !i | !inventory

See your inventory and currently equipped items.  

```
!inventory
~~ Nick Name ~~
Equipped:
  Weapons:
    [Bear Arms]
    [Empty]
  Shirt:
    [Defcon T-Shirt]
  Pants:
    [No Pants Bro, they'z lost or some shit]
  Shoes:
    [Cool Dance Shoes]
  Hair Style:
    [Dragon Ball Z]

Backpack Contents:
  > Laptop rolling something linux based
  > Laser
```

#### !e | !equip

Equips an item.

```
!equip Laser
* Nickname has equipped his Laser *
```


## Exploring Commands

#### !pick_lock

Use your lock picking skill to see if you can get past the door.


#### !look

Recieve a message about what the current part of the dungeon looks like.  


#### !go [north|south|east|west]

Travel through the dungeon to get to rooms and stuff.  


#### !explore

Explore to a new area of the current dungeon, marking it on the map.  


#### !map

Print the map of the current zone


#### !worldmap

Print the world map


#### !travel_town

Vote for the next location to travel to next after the next travel interval occurs...
Everyone 30 minutes, the channel must leave the dungeon its currently exploring along the quest line and go back to town to replenish???




## Commerce Commands

#### !t | !trade

Trade items with friends.  Be nice!

#### !market

Opens the market sub menu where you can sell loot and buy potions and spells.  





## Development

### Testing

You should use test driven development to make progress on this.  Firstly, that means you don't manually boot up the app to check how a change you made to the code effects its outputs, rather you run `rake` and check how your change effects the outputs.  You'll probably need to write your own test or expand one of the existing pending tests.  

e.g. the below pending test...

```
it "should do a thing that was once considered but no one had to to implement"
```

Might become...

```
it "should do a thing that was once considered but no one had to to implement" do
  # This kind of puts a break point in your code so you can try running commands
  # It's indispensable in the ruby world and it along with unit tests is the
  # reason we don't bother with code debuggers
  binding.pry
  expect($Game.thing_that_was_considered).to eq :it_returned_this_expected_symbol
end
```


When tests fail, at the bottom of the screen, it prints the command to run specifically that test.  Try not to make changes in other parts of the code that cause other tests to break unless it's clear that it's a good idea (the other tests seemed like stubs) or you've created an issue to bring up some insufficiencies of what may have actually been intended design (it may well have been an oversight).  


To run all the tests, you need to at least run an IRC server locally and have config/application.yml configured correctly to connect to it.  Theoretically you could use a remote IRC server, but that's less flexible.  Additionally, as bazz showed me, you can substantially decrease the connection times by also running a ZNC server locally which kind of sits there maintaining a connection to an IRC server so you don't need to waste time re-handshaking with that ancient protocol.  Once that's done you're good, run `rake` like any other piece of professional open source software.  

You can use bin/console to play around with things too.  But ideally you'll just create a new test for the feature you're working on.  


## License

GNU AGPL v3


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/adventure_channel.
