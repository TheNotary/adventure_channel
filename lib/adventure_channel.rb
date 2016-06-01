require 'cinch'
require 'figaro'

require "adventure_channel/version"

module AdventureChannel

  def launch_bot

    bot = Cinch::Bot.new do
      configure do |c|
        c.nick = ENV['irc_nick']
        c.server = ENV['irc_server']
        c.channels = [ENV['irc_channel']]
        c.verbose = true
      end

      on :message, "hello" do |m|
        m.reply "Hello, #{m.user.nick}"
      end
    end

    bot.start
  end

end
