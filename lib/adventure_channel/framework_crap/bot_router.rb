module AdventureChannel

  module BotRouter

    def self.instantiate_bot
      include AdventureGame

      ######################
      #  Bot Configuration #
      ######################

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
      end
    end
  end
end
