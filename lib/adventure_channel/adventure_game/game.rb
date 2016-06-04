module AdventureChannel

  module AdventureGame

    class Game

      attr_reader :current_battle, :mobs

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
        return "A battle is already in progress" if @current_battle

        @current_battle = Battle.new
        @current_battle.spawn_mob(Mob.create(name: 'Green Goblin', hp: 20))

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

      # This is leading up to a way to lookup a user from the redis database
      # FIXME: move me into the User model
      def find_or_create_user(name)
        u = User.all.find(name: name).first
        if u.nil?
          u = User.spawn_for_new_player(name: name)
        end
        return u
      end

    end

  end

end
