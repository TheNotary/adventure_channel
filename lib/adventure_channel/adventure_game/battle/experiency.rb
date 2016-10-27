module AdventureChannel
  module AdventureGame

    # Experiency
    #
    # User's gain exp from killing monsters, and they level up, gain more
    # attributes, and otherwise become more awesome.  This module homes the
    # logic related to this feature.
    module Experiency

      # The key/ value database "scheme" is represented here
      def self.included(base)
        base.instance_eval do

          ##########
          # Schema #
          ##########
          
          attribute :exp, lambda { |x| x.to_i }
          # attribute :attribues_for_level, lambda { |x| x.to_i }
        end
      end

      # exp isn't available in level_calculation... <-- ???
      def level
        level_calculation
      end

      def attribues_for_level
        attribues_for_level_calculation
      end

      # sums stats like strength, agility, hp, to see how many attributes have been
      # applied to a unit's bases states.
      def sum_allocated_attributes
        :stubbed
      end

      # TODO: finish this when you test leveling up
      def can_apply_earned_attribute?
        # sum_of_stats > attribues_for_level + bonus_attributes
      end

    end
  end
end
