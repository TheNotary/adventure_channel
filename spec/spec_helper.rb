$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
$app_env = 'test'
require 'pry'
require 'adventure_channel'
require 'environment_helper'
include AdventureChannel::AdventureGame

check_test_environment!

# load the redis database
AdventureChannel.init_redis
AdventureChannel.populate_database

def uber_quit
  $adventure_channel_bot.quit if $adventure_channel_bot
  $test_master_bot.quit if $test_master_bot # .data[:online?]

  loop until Thread.list.count == 1
  puts "OK, threads killed"
  exit
end

def launch_adventure_channel_bot
  Thread.new { AdventureChannel.launch_bot }
  loop until $adventure_channel_bot
  loop until $adventure_channel_bot.data[:online?]
  $adventure_channel_bot
end



def resetMessageBuffers
  $MessagesPM = []
  $MessagesChannel = []
end
resetMessageBuffers

# IRC Helper integration tests
def launch_admin_bot
  test_master_bot = Cinch::Bot.new do
    configure do |c|
      c.nick =  ENV['test_irc_nick']
      c.password = ENV['test_irc_password'] unless ENV['test_irc_password'].to_s == ""
      c.server =  ENV['irc_server']
      c.port = ENV['irc_port']
      c.channels = ENV['irc_channel'].split
      c.server_queue_size = ENV['irc_server_queue_size'].to_i
      c.messages_per_second = ENV['irc_messages_per_second'].to_f
    end

    on :connect do |m|
      $test_client_connected = true
    end

    on :message do |m|
      $MessagesPM << m.message
      $EventHappened = true
    end

    on :channel do |m|
      $MessagesChannel << m.message
      $EventHappened = true
    end

  end
  test_master_bot.loggers.first.level = :fatal

  $test_master_bot = test_master_bot

  t1 = Thread.new do
    test_master_bot.start
  end

  loop until test_master_bot.data[:online?]
  test_master_bot
end

def wait_until_irc_event_happens
  $EventHappened = nil
  loop until $EventHappened
end

def wait_for_messages_pm(n_messages)
  loop until $MessagesPM.count >= n_messages
end

def wait_for_messages_channel(n_messages)
  loop until $MessagesChannel.count >= n_messages
end
