module AdventureChannel

  module AdventureGame

    class Game

      attr_reader :battle, :mobs

      def initialize

      end

      def status
        if @battle
          :in_battle
        else
          :idle
        end
      end

      # FIXME: move to Battle class
      def start_battle
        return "A battle is already in progress" if @battle

        @battle = Battle.new
        @battle.spawn_mob(Mob.create(name: 'Green Goblin', hp: 20))

        "A battle has started"
      end

      def inventory_for(player)

      end


      # This method communicates to users through the distribution system
      # (http/ ws/ irc message) that something has happened
      # Below is IRC_ANNOUNCEs implementation which should be extracted to its
      # own class FIXME: extract
      def create_announcement(symbol)
        case symbol
        when :battle_started
          h = { respond_to: :sender,
                message: "A battle has started"}
        end

      end



    end

  end

end
