require 'cinch'
require 'figaro'
require 'redis'
require 'ohm'
# require 'ohm/contrib'
require 'json'

# Hoisting realllyyyyy matters here....
require "adventure_channel/adventure_game"
require "adventure_channel/framework_crap"
require "adventure_channel/version"

$app_env = 'production'

Figaro.application.path = File.expand_path('../../config/application.yml', __FILE__)
Figaro.load

module AdventureChannel

  def self.init_redis
    Ohm.redis = Redic.new("redis://#{ENV['redis_host']}:#{ENV['redis_port']}")
    populate_database

    Ohm.redis
  end

  # upon boot, all items will get loaded into redis (yes... again)
  def self.populate_database
    populate_items
    populate_monsters
  end

  def self.populate_items
    items = JSON.parse(File.read(File.expand_path('../../config/items.json', __FILE__)))["items"]
    items.each do |i|
      c = { name: i["name"],
            item_class: i["item_class"],
            value: i["value"],
            meta: i["meta"].to_json}
      c = c.merge({code: i["code"]}) if i["code"]

      Item.create(c)
    end
  end

  def self.populate_monsters
    mobs = JSON.parse(File.read(File.expand_path('../../config/beastiary.json', __FILE__)))["beastiary"]

    mobs.each do |i|
      c = { code: i["code"],
            name: i["name"],
            loot: i["loot"],
            abilities: i["abilities"].to_json,
            special_permenant_modifiers: i["special_permenant_modifiers"].to_json,
            base_attributes: i["base_attributes"].to_json
      }

      # Anything missing from base_attributes SHOULD be assumed to be a '1'
      Mob.create(c)
    end

  end

  # This method includes the routing information for the app more or less
  def self.launch_bot
    include AdventureGame

    @redis = init_redis

    $Game = AdventureGame::Game.new

    @bot = Cinch::Bot.new do
      configure do |c|
        c.nick = ENV['irc_nick']
        c.password = ENV['irc_password'] unless ENV['irc_password'].to_s == ""
        c.server = ENV['irc_server']
        c.port = ENV['irc_port']
        c.channels = ENV['irc_channel'].split
        c.server_queue_size = ENV['irc_server_queue_size'].to_i
        c.messages_per_second = ENV['irc_messages_per_second'].to_f
      end

      ################
      #    Routes    #
      ################
      #
      # Hint, look in adventure_game/framework_crap/controller.rb to see what
      # methods are being fired from here

      # help
      on :message, /^!help/,       {}  { |m| respond_to_help(m) }
      on :message, /^!h(?:\s+|$)/, {}  { |m| respond_to_help(m) }

      #
      # Player Related
      #

      # inventory
      on :message, /^!inventory/,  {}  { |m| respond_to_inventory(m) }
      on :message, /^!i(?:\s+|$)/, {}  { |m| respond_to_inventory(m) }

      # equipment
      on :message, /^!equipment/,  {}  { |m| respond_to_equipment(m) }
      on :message, /^!e(?:\s+|$)/, {}  { |m| respond_to_equipment(m) }

      # status
      on :message, /^!status/,  {}     { |m| respond_to_status(m) }
      on :message, /^!s(?:\s+|$)/, {}  { |m| respond_to_status(m) }

      # check
      on :message, /^!check/,  {}  { |m| respond_to_check(m) }
      on :message, /^!c(?:\s+|$)/, {}  { |m| respond_to_check(m) }

      #
      # Battle Related
      #

      # This starts a new battle assuming one isn't in progress
      # [system] initiate_battle
      on :message, /^!initiate_battle/, {} { |m| respond_to_initiate_battle(m) }

      # This makes the next up mob attack
      # [system] queue_next_mob_action
      on :message, /^!queue_next_mob_action/, {} { |m| respond_to_queue_next_mob_action(m) }

      # This method makes it so that players can take their next turns
      # [system] queue_adventurers_turn_tick
      on :message, /^!queue_adventurers_turn_tick/, {} { |m| respond_to_queue_adventurers_turn_tick(m) }


      # join
      on :message, /!join/,        {}  { |m| respond_to_join(m) }

      # fight
      on :message, /^!fight/,      {}  { |m| respond_to_fight(m) }
      on :message, /^!f(?:\s+|$)/, {}  { |m| respond_to_fight(m) }

      #
      # World Related
      #

      # on :message, /!explore/,        {}  { |m| respond_to_join(m) }




      # FIXME: example, remove this
      on :message, /^!msg (.+?) (.+)/ do |m, who, text|
        User(who).send text
      end

    end

    $adventure_channel_bot = @bot
    @bot.start
  end

end
