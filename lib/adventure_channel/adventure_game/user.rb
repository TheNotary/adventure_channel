module AdventureChannel

  module AdventureGame

    class User < Ohm::Model    # < Unit
      attribute :name
      attribute :equipment
      attribute :inventory

      index :name
      # attribute :id

      attr_accessor :name, :equipment, :inventory # , :id

      #
      # def initialize(name: nil)
      #   @name = name
      #   # @id = id
      #
      #   @equipment = { right_hand: Item.find_by(name: "Jaggedly sharp e-waste specimen") } # {left_hand: 'axe', right_hand: 'axe'}
      #   @inventory = ['heavily chlorinated water']
      # end

      # this function will change depending on what database is used
      # def set_id(id)
      #   @id = id
      # end


    end

  end

end
