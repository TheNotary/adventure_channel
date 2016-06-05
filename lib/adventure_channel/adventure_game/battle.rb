module AdventureChannel

  module AdventureGame

    class Battle
      attr_reader :mobs, :participants, :status

      def initialize
        @mobs = []
        @participants = []
        @status = :idle
      end

      def spawn_mob(mob)
        @mobs << mob
        self
      end


      def start(mobs: nil)
        return "A battle is already in progress" if @status != :idle

        if mobs.nil?
          mobs = []
          spawn_mob(Mob.create(name: 'Green Goblin', hp: 20))
        else
          @mobs = mobs unless mobs.nil?
        end

        @status = :in_battle

        "A battle has started"
      end


      def fight(attacker: , defender: nil)
        mob = mobs.shift if defender.nil?
        fight_statistic = []
        effects_for_attacker = []
        effects_for_defender = []

        @participants << attacker unless @participants.include?(attacker)

        # lookup users dmg rating
        user_dmg_rating = 1

        # apply_attack to mob's HP
        mob.hp -= user_dmg_rating
        mob.save

        fight_statistic << "[#{attacker.name}] dmgs the #{mob.name} for 1pt"

        # Mob death check
        if mob.hp <= 0
          # Grant EXP to all combatants
          effects_for_attacker << "You gained 1 exp"
          effects_for_defender << "You died =/"

          fight_statistic << ">> The #{mob.name} is slain <<"
          mob.delete

          # check if all mobs are now dead!
          if mobs.count <= 0
            fight_statistic << ">>~ The Battle is Won ~<<"

          end
        else
          mobs.unshift(mob)  # puts the mob back in the mobs list
        end

        responses = { fight_statistic: fight_statistic,
                      effects_for_attacker: effects_for_attacker,
                      effects_for_defender: effects_for_defender }
      end

    end

  end

end
