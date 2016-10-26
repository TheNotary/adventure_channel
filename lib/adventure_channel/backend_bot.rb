require 'cinch'

###############
# Backend Bot #
###############
#
# Responsibilities:
#   Coordinate battles and mob creation -
#     Recieve requests (from AdventureChannel) for !request_battle and issue
#     requests for !initiate_battle instructing adventure_channel to spawn mobs
#     of the backend bot's choosing.
#
#   Grant exp from mob kills -
#     Recieve requests (from AdventureChannel) to grant exp.  Records exp in
#     db.  Signals AdventureChannel the amount of earned exp of the participants
#     ``
#
#   Coordinates item creation/ granting -
#     
#
#   Recieve requests
#
# This plugin is responsible for signaling the adventure channel bot with
# server commands such as `!initiate_battle` and also issues out EXP I think...
class Backend
  include Cinch::Plugin
  match /^!request_exp (.+)/, method: :request_exp
  match /^!request_battle (.+)/, method: :request_battle
  match /^command3 (.+)/, use_prefix: false

  def request_battle(m, arg)
    m.reply "command2, arg: #{arg}"
  end

  def request_exp(m, arg)
    m.reply "command1, arg: #{arg}"
  end

  def execute(m, arg)
    m.reply "command3, arg: #{arg}"
  end
end

bot = Cinch::Bot.new do
  configure do |c|
    c.nick            = "backend"
    c.server          = "irc.freenode.org"
    c.channels        = ["#cinch-bots"]
    c.verbose         = false
    c.plugins.plugins = [Backend]
  end
end

bot.start
