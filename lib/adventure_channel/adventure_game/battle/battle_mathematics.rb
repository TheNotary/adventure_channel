module AdventureChannel
  module AdventureGame

    module BattleMathematics

      # Given exp, this function determines what level a player or monster is
      def level_calculation
        # alternative equation:  int((1.0282*(level^3))+(0.02*(level^2))+(8.09*level)-8.2)  ... this should be married to exp granted by mobs too of course
        earliness = 0 # this could be randomized for the player and based off of a level calculation
        ( 0.5 * Math.sqrt(exp + earliness) ).ceil
      end

      def attribues_for_level_calculation
        attributes = 6 + level * 4
      end

      def calculate_damage_against(defender)
        dmg = effective_atk - defender.effective_defense
      end

      def atk_from_stats_calculation
        (effective_strength * 2) + (effective_agility)
      end

      def defense_from_stats_calculation
        effective_strength
      end

      def mgk_defense_from_stats_calculation
        0
      end

      def mgk_atk_from_stats_calculation
        0
      end

    end

  end
end
