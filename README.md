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

Get status of the room:

```
~ A [lvl 2 green goblin {gg1}] appeared 2 minutes ago ~
> No one has helped fend it off yet!
> It's stealing things from the channel coffer.
```


### Battle Commands

#### !j | !join

Type !j to join the battle, this command will likely be deprecated since joining
the battle can be inferred by performing game actions.  

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


### Commerce Commands

#### !t | !trade

Trade items with friends.  Be nice!

#### !market

Opens the market sub menu where you can sell loot and buy potions and spells.  


### World Map Commands

#### !explore

Explore a new area of the current dungeon, marking it on the map


#### !map

Print the map of the current zone


#### !worldmap

Print the world map


#### !travel

Vote for the next location to travel to next after the next travel interval occurs...
Everyone 30 minutes, the channel must leave the dungeon its currently exploring along the quest line and go back to town to replenish???



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/adventure_channel.
