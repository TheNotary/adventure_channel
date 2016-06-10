module AdventureChannel

  module AdventureGame

    class Battle
      attr_reader :mobs, :participants, :status

      def initialize
        @mobs = []
        @participants = []
        @status = :idle
      end

      # Adds a new mob to an in-progress battle
      #
      # @param [Array<Mob>] mobs
      #    Array of mobs to spawn as the battle is initiated.
      # @see Battle#spawn_new_mob
      def spawn_new_mob(params)
        @mobs << Mob.spawn(params)
        self
      end

      # Starts a battle.  If no parameters are specified, default values will be
      # used.
      #
      # @param [Array<Hash>] mobs
      #    Array of mob configurations to spawn as the battle is initiated.  As
      #    a minimum, your Hash configs must include a `code` key.
      # @param [Hash] mobs
      #    To spawn just one mob, instead of passing in a hash, just pass in
      #    the configs for a single mob.
      # @see Battle#start
      def start(mobs: nil)
        return { invoker_messages: ["A battle is already in progress"] } if @status != :idle

        # assign_mobs_to_battle(mobs)
        @mobs = assign_mobs_to_battle(mobs)

        @status = :in_battle

        responses = { invoker_messages: ["A battle has started"],
                      channel_messages: [battle_start_announcement] }
      end

      def battle_start_announcement
        script = (@mobs.count > 1) ? "~ A group of monsters has appeared ~" : "~ A monster has appeared ~"
        script = [script]

        @mobs.each { |m| script << "> lvl #{m.level} #{m.name}" }

        script.join("\n")
      end

      def assign_mobs_to_battle(mobs)
        if mobs.class == Array
          @mobs = mobs.collect {|params| Mob.spawn(params)}
        elsif mobs.class == Hash # assume a single mob config was passed in not many in an array
          mob_config = mobs
          @mobs = [Mob.spawn(mob_config)]
        else
          @mobs = [ Mob.spawn(code: 'mob-0001', hp: 20) ] # default mob
        end
      end


      def fight(attacker: , defender: nil)
        mob = mobs.shift if defender.nil?
        fight_statistic = []
        effects_for_attacker = []
        effects_for_defender = []

        @participants << attacker unless @participants.include?(attacker)

        # lookup users dmg rating
        user_dmg_rating = attacker.calculate_damage_against(mob)

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
