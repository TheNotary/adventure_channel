require 'cinch'
require 'figaro'
require 'redis'
require 'ohm'
require 'ohm/contrib'
require 'json'

require "adventure_channel/adventure_game"
require "adventure_channel/version"

Figaro.application.path = File.expand_path('../../config/application.yml', __FILE__)
Figaro.load

module AdventureChannel

  def self.init_redis
    Ohm.redis = Redic.new("redis://#{ENV['redis_host']}:#{ENV['redis_port']}")
    populate_database

    # @redis = Redis.new({
    #   host: ENV['redis_host'],
    #   port: ENV['redis_port'],
    #   db: ENV['redis_db_id']})
    Ohm.redis
  end

  # upon boot, all items will get loaded into redis (yes... again)
  def self.populate_database
    items = JSON.parse(File.read(File.expand_path('../../config/items.json', __FILE__)))["items"]

    items.each do |i|
      c = { name: i["name"],
            item_class: i["item_class"],
            value: i["value"],
            meta: i["meta"]}
      c = c.merge({code: i["code"]}) if i["code"]

      Item.create(c)
    end

  end

  def self.launch_bot
    @redis = init_redis
    @game = AdventureGame::Game.new

    @bot = Cinch::Bot.new do
      configure do |c|
        c.nick = ENV['irc_nick']
        c.server = ENV['irc_server']
        c.channels = [ENV['irc_channel']]
        c.verbose = true
      end

      # inventory
      on :message, /(^!inventory|^!i)/ do |m|
        resp = @game.users.find(m.user.nick).inventory
        m.user.send "~~ #{m.user.nick} ~~"
      end

      # join
      on :message, /[\!join|\!j]/ do |m|

      end




      on :message, /^!msg (.+?) (.+)/ do |m, who, text|
        User(who).send text
      end

      # this is something that the backend fires to start a new battle
      on :message, /^!initiate_battle (.+)/ do |m, auth_token|
        return unless auth_token == ENV['auth_token']
        return if @game.status == :in_battle

        resp = @game.start_battle(m)

        m.user.send resp
      end

      on :message, /^[!f|!fight] (.+?)/ do |m, which_mob|
        # get mob
        # apply_attack to mob's HP
        # announce
        m.reply "You fought a mob!"
      end



    end

    @bot.start
  end


  # This is the IRC version
  # def self.announce(m, resp)
  #   case resp[:respond_to]
  #   when :sender
  #     m.user.send resp[:message]
  #   when :channel
  #     m.reply resp[:message]
  #   when :admin
  #   end
  # end


end
