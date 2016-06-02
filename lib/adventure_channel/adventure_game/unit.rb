module AdventureChannel

  module AdventureGame

    class Unit < Ohm::Model
      attr_reader :name, :hp, :mp

      def initialize(name:, hp:, mp: nil)
        @name = name
        @hp
        @mp
      end

    end

  end

end
