module AdventureChannel

  module AdventureGame

    class Game
      attr_reader :current_battle, :mobs, :players

      def initialize

      end

      def status
        if @current_battle
          :in_battle
        else
          :idle
        end
      end

      def start_battle
        return nil if @current_battle

        @current_battle = Battle.new
        @current_battle.spawn_mob(Unit.new(name: 'Green Goblin', hp: 20))

        # create_announcement(:battle_started)
        "A battle has started"
      end

      def inventory_for(player)

      end

      def add_player_battle(player)

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

      def users
        
      end

    end

  end

end
