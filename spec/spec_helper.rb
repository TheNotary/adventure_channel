$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pry'
require 'adventure_channel'
$app_env = 'test'
include AdventureChannel::AdventureGame

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
      c.nick = "testc"
      c.server = "127.0.0.1"
      c.channels = [ENV['irc_channel']]
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
