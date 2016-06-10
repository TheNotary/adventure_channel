module AdventureChannel
  module AdventureGame
    class Loadout < Ohm::Model
      attribute :head_id
      reference :head,          :Item
      attribute :right_hand_id
      reference :right_hand,    :Item
      attribute :left_hand_id
      reference :left_hand,     :Item
      attribute :body_id
      reference :body,          :Item
      attribute :legs_id
      reference :legs,          :Item
      attribute :feet_id
      reference :feet,          :Item
      attribute :wrist_id
      reference :wrist,         :Item
      attribute :neck_id
      reference :neck,          :Item

      def self.spawn_for_new_player
        s = self.create
        s.right_hand = Item.find(code: "wep-0001").first
        s.legs = Item.find(code: "legs-0001").first
        s.save
        s
      end

      def pieces
        [:right_hand, :left_hand, :head, :body, :legs, :feet, :wrist, :neck]
      end

    end
  end
end
