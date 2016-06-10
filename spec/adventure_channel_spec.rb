require 'spec_helper'

describe AdventureChannel do
  it 'has a version number' do
    expect(AdventureChannel::VERSION).not_to be nil
  end

  # 1)  Launch the IRC bot into the irc server specified in application.yml
  # 2)  Launch a test client/ admin bot into that channle too so it can do messages
  # 3)  Go through the full set of 'features' all in this one massive test
  #
  # Note... this is the most straightforward place to start 'testing' your feature
  # and get your head thinking about how to make the feature happen, but this
  # part of the code base will likely be a mess of merge conflicts so try to
  # bear that in mind as you wait for PRs to be merged.
  it 'can have a monster attack the channel' do
    if $IsIRCServerListening # skip this test if they can't connect to IRC

      @irc_game = launch_adventure_channel_bot

      @irc_admin = launch_admin_bot
      channel = @irc_admin.channels.first


      adventure_channel_user = get_user_from_name(@irc_admin, ENV['irc_nick'])

      # Can pull up inventory
      resetMessageBuffers
      adventure_channel_user.send "!inventory"
      wait_for_messages_pm(3)

      # TODO:  Make it so tests relating to $MessagesPM don't sometimes fail
      expect($MessagesPM).to include("Backpack Contents:")


      # Can Initiate a battle
      resetMessageBuffers
      adventure_channel_user.send "!initiate_battle #{ENV['auth_token']}"
      # channel.send "!initiate_battle #{ENV['auth_token']}"
      wait_for_messages_pm(1)
      wait_for_messages_channel(2)

      expect($MessagesPM).to include("A battle has started")

      expect($MessagesChannel).to include("~ A monster has appeared ~")
      expect($MessagesChannel).to include("> lvl 0 Green Goblin")


      # TODO: Write mob stealing from the channel's treasury
      # A mob can beginning stealing from the channel's treasury
      binding.pry

      # TODO: Write test for A mob can attack a player

      # Can Attack a mob and win a battle
      mob = $Game.battle.mobs.first
      mob.hp = 1
      mob.save
      resetMessageBuffers
      channel.send "!fight"

      wait_for_messages_channel(3)



      expect($MessagesChannel[0]).to eq("[#{@irc_admin.nick}] dmgs the Green Goblin for 1pt")
      expect($MessagesChannel[1]).to eq(">> The Green Goblin is slain <<")
      expect($MessagesChannel[2]).to eq(">>~ The Battle is Won ~<<")

      # TODO: You can recieve loot from slain mobs


      # Can gain exp from killing a mob and level up
      wait_for_messages_pm(1)
      expect($MessagesPM.last).to eq("you earned 2xp")

      # TODO: implement leveling up
      # You can check your status and see your level

      # TODO:
      # You can equip items and change the amount of damage you do

      #
    end

  end
end

def get_user_from_name(irc_client, user_name)
  user = irc_client.user_list.select {|u| u.nick == user_name}.first
end
