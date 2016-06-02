module AdventureChannel

  module AdventureGame

    class User < Unit
      include Redis::Objects

      attr_accessor :nick, :equipment, :inventory

      def initialize
        @equipment = { right_hand: Item.find_by(name: "Jaggedly sharp e-waste specimen") } # {left_hand: 'axe', right_hand: 'axe'}
        @inventory = ['heavily chlorinated water']
      end



    end

  end

end
