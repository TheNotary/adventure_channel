module AdventureChannel
  module AdventureGame

    module BattleMathematics

      # Given exp, this function determines what level a player or monster is
      def level_calculation
        # alternative equation:  int((1.0282*(level^3))+(0.02*(level^2))+(8.09*level)-8.2)  ... this should be married to exp granted by mobs too of course
        earliness = 0 # this could be randomized for the player and based off of a level calculation
        ( 0.5 * Math.sqrt(exp + earliness) ).ceil
      end

    end
    
  end
end
