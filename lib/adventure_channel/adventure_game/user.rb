module AdventureChannel

  module AdventureGame

    class User < Ohm::Model
      battleable

      def self.spawn_for_new_player(name: nil)
        s = self.create(name: name)
        s.equipment = Loadout.spawn_for_new_player
        s
      end

      def furnish_with_default_equipment
        # @equipment = { right_hand: "Jaggedly sharp e-waste specimen" } # {left_hand: 'axe', right_hand: 'axe'}
      end


    end

  end

end
