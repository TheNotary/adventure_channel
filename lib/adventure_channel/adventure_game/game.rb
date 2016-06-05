module AdventureChannel

  module AdventureGame

    class Game

      attr_reader :battle, :mobs

      def initialize
        @battle = Battle.new
      end

      def status
        s = @battle.status
        return "in dungeon or some town???".to_sym if s == :idle
        return s
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
