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
    launch_adventure_channel_bot

    @irc_admin = launch_admin_bot
    channel = @irc_admin.channels.first

    adventure_channel_user = get_user_from_name(@irc_admin, ENV['irc_nick'])

    # Initiate a battle
    resetMessageBuffers
    adventure_channel_user.send "!initiate_battle #{ENV['auth_token']}"
    # channel.send "!initiate_battle #{ENV['auth_token']}"
    wait_for_messages_pm(1)
    latest_message = $MessagesPM.last
    expect(latest_message).to eq("A battle has started")


    # Attack the mob
    resetMessageBuffers
    channel.send "!fight"
    wait_for_messages_channel(1)
    expect($MessagesChannel[0]).to eq("#{@irc_admin.nick} dmgs goblin for 1pt")

  end
end

def get_user_from_name(irc_client, user_name)
  user = irc_client.user_list.select {|u| u.nick == user_name}.first
end
