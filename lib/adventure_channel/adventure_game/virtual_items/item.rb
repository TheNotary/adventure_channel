module AdventureChannel
  module AdventureGame

    class Item < Ohm::Model
      # include Ohm::DataTypes

      attribute :name;   index :name
      attribute :code;   index :code
      attribute :value, lambda { |x| x.to_i }

      # item_class = weapon | armor | consumable | quest_item
      attribute :item_class

      # The meta attribute for Items indicates it's class specific data
      # different item_classes will have different data hash layouts, eg...
      # weapons: { "dmg": "1", "type": "thunder", "swing_time": "2.1" }
      # armor: { "slot": ["legs"], "def": "1", "weight": "1", "resistance-cold": "50", "modify-max_hp": "1" }
      # consumable: { "effect-current_hp": "10" }
      # quest_items only have names
      attribute :meta  #, Type::Hash

      # For collection within inventory
      # reference :user, :User


    end

  end
end
