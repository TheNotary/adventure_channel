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

  # This method includes the routing information for the app more or less
  def self.launch_bot
    init_redis
    $Game = AdventureGame::Game.new

    $adventure_channel_bot = @bot = BotRouter.instantiate_bot
    @bot.start # Blocking call... should be listen
  end

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
    path_to_json_file = File.expand_path('../../config/beastiary.json', __FILE__)

    mobs = JSON.parse(File.read(path_to_json_file))["beastiary"]

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

end
