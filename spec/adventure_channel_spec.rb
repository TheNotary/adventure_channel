require 'spec_helper'

describe AdventureChannel do
  it 'has a version number' do
    expect(AdventureChannel::VERSION).not_to be nil
  end

  it 'does something useful' do
    # binding.pry
  end

  # 1)  Launch the bot
  # 2)  Initiate code for starting a battle and spawning a mob that would
  #     otherwise be caused by an IRC message from an external server or thread
  # 3)  check that expected message was recieved by the test bot
  it 'can have a monster attack the channel' do
    @irc_game = launch_adventure_channel_bot

    @irc_admin = launch_admin_bot
    channel = @irc_admin.channels.first


    adventure_channel_user = get_user_from_name(@irc_admin, ENV['irc_nick'])

    # Can pull up inventory
    resetMessageBuffers
    adventure_channel_user.send "!inventory"
    wait_for_messages_pm(3)

    # TODO:  Figure out why this test sometiems fails...
    binding.pry if $MessagesPM.first == "  > Laser"

    expect($MessagesPM.first).to eq("Backpack Contents:")


    # Can Initiate a battle
    resetMessageBuffers
    adventure_channel_user.send "!initiate_battle #{ENV['auth_token']}"
    # channel.send "!initiate_battle #{ENV['auth_token']}"
    wait_for_messages_pm(1)

    expect($MessagesPM.last).to eq("A battle has started")


    # Can Attack a mob
    mob = $Game.battle.mobs.first
    mob.hp = 1
    mob.save
    resetMessageBuffers
    channel.send "!fight"

    wait_for_messages_channel(3)

    expect($MessagesChannel[0]).to eq("[#{@irc_admin.nick}] dmgs the Green Goblin for 1pt")
    expect($MessagesChannel[1]).to eq(">> The Green Goblin is slain <<")
    expect($MessagesChannel[2]).to eq(">>~ The Battle is Won ~<<")


    # Can gain exp from killing a mob
    # wait_for_messages_pm(1)
    # expect($MessagesPM.last).to eq("you earned 2xp")




  end
end

def get_user_from_name(irc_client, user_name)
  user = irc_client.user_list.select {|u| u.nick == user_name}.first
end
