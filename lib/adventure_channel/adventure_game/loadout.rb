module AdventureChannel
  module AdventureGame
    class Loadout < Ohm::Model
      reference :head,       :Item
      reference :right_hand, :Item
      reference :left_hand,  :Item
      reference :body,       :Item
      reference :legs,       :Item
      reference :feet,       :Item
      reference :wrist,      :Item
      reference :neck,       :Item

      def self.spawn_for_new_player
        s = self.create
        s.right_hand = Item.find(code: "wep-0001").first
        s.legs = Item.find(code: "legs-0001").first
        s
      end
    end
  end
end
