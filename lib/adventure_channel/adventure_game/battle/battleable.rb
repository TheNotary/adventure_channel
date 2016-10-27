require 'adventure_channel/adventure_game/battle/battle_mathematics'
require 'adventure_channel/adventure_game/battle/stats_helper'
require 'adventure_channel/adventure_game/battle/experiency'

module AdventureChannel
  module AdventureGame

    Resistances = [:white, :dark, :cold, :fire, :thunder, :poison]
    BasicCombatStats = [:strength, :stamina, :agility, :intelligence, :spirit]
    PercentageCombatStats = [:eva, :pre, :mgk_eva, :mgk_pre]
    CompositCombatStats = [:defense_base, :atk_base, :mgk_atk_base, :mgk_defense_base]

    # Battleable
    #
    # Objects that can perform attacks, have damage calculations, etc. are given
    # methods from the Battleable module.
    module Battleable
      include BattleMathematics
      include StatsHelper

      def self.included(base)
        this = self #// js ftw!

        # We have to evaluate this code within the context of the class that's
        # including this method to get access to work with Ohm and the way they
        # went with inheritance rather than composition/ mixins =(
        base.instance_eval do
          include Experiency

          ##########
          # Schema #
          ##########

          attribute :name;       index :name

          # state
          attribute :hp, lambda { |x| x.to_i }
          attribute :mp, lambda { |x| x.to_i }
          attribute :max_hp, lambda { |x| x.to_i }
          attribute :max_mp, lambda { |x| x.to_i }

          # Basic Stats
          attribute :strength, lambda { |x| x.to_i }
          attribute :stamina, lambda { |x| x.to_i }
          attribute :agility, lambda { |x| x.to_i }
          attribute :intelligence, lambda { |x| x.to_i }
          attribute :spirit, lambda { |x| x.to_i }

          # Percentage Stats
          attribute :eva, lambda { |x| x.to_i }
          attribute :pre, lambda { |x| x.to_i }
          attribute :mgk_eva, lambda { |x| x.to_i }
          attribute :mgk_pre, lambda { |x| x.to_i }

          # Base values of composit stats
          attribute :mgk_atk_base, lambda { |x| x.to_i }
          attribute :atk_base, lambda { |x| x.to_i }
          attribute :defense_base, lambda { |x| x.to_i }
          attribute :mgk_defense_base, lambda { |x| x.to_i }

          attribute :special_permenant_modifiers # eg { special_permenant_modifiers: [ "jaunt_quest_completed": [ modify-resist_fire": "10", "modify-title": "Super Cool Dude"] }
          attribute :status_effects

          attribute :abilities
          attribute :white_magic
          attribute :black_magic
          attribute :summon

          list :inventory, :Item

          attribute :equipment_id
          reference :equipment, :Loadout

          ################
          # Meta Methods #
          ################

          this.setup_stats
        end
      end


      # There's a lot of dynamic method creation going on because the same
      # methods will be created for each stat type (:strength, :endurance, :health, :etc)
      # Thing kind of meta programming was popularized in rails with helper
      # methods such as edit_MODEL_NAME_path and new_MODEL_NAME_path where
      # methods are defined based on the creation of entries in the creation of
      # new models.
      def self.setup_stats
        ##########################################
        #   Metaprogramming Method Definitions   #
        ##########################################

        StatsHelper.resistence_stat_definitions # e.g. resist_cold

        # The printer methods allow battleable objects to print their
        # stats to strings
        StatsHelper.resistances_printer  # e.g. p_cold

        StatsHelper.effective_combat_stat_definitions
        StatsHelper.composit_stat_printer

        StatsHelper.percentage_combat_stat_definitions
        StatsHelper.percentage_combat_stat_printer
      end

      # [Composite Stat]
      # Attack is special because it is both a base stat inherint to the battler,
      # but also a calculation _based on other stats_ and of course direct
      # modifiers...  a composite stat
      def effective_atk
        atk_base + sum_property_of_items("atk") + atk_from_stats_calculation
      end

      # [Composite Stat]
      def effective_defense
        defense_base + sum_property_of_items("defense") + defense_from_stats_calculation
      end

      def effective_mgk_defense
        mgk_defense_base + sum_property_of_items("magic_defense") + mgk_defense_from_stats_calculation
      end

      def effective_mgk_atk
        mgk_atk_base + sum_property_of_items("magic_atk") + mgk_atk_from_stats_calculation
      end

      def sum_property_of_items(property)
        return 0 if equipment.nil?
        sum = 0
        equipment.pieces.each do |piece_sym|
          piece = equipment.send(piece_sym)
          sum += JSON.parse(piece.meta)[property].to_i unless piece.nil?
        end

        sum
      end

      # TODO: when this gets implemented, I think status_effects should store a
      # datastructure that looks like...
      # { status_effects: [ { spell_fortitude: { expires_at: "SOMETIME", modify-def: "2" } } ]
      def collect_from_status_effects(key)
        # s = JSON.parse(status_effects)
      end

    end
  end
end
