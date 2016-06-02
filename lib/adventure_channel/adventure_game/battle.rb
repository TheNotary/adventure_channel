module AdventureChannel

  module AdventureGame

    class Battle
      attr_reader :mobs

      def initialize()
        @mobs = []
      end

      def spawn_mob(mob)
        @mobs << mob
        self
      end

    end

  end

end
