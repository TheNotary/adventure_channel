module AdventureChannel
  module Controller
    # include AdventureChannel::AdventureGame

    def respond_to_inventory(m)
      resp = $Game.users.find(m.user.nick).inventory
      m.user.send "~~ #{m.user.nick} ~~"
    end

    def respond_to_join(m)
    end

    # This is something that the backend signlals to the IRC client to start a
    # new battle
    def respond_to_initiate_battle(m)
      if authorization_denied?(m)
        m.user.send "Fatal:  Authorization denied" && return
      end

      resp = $Game.start_battle
      m.user.send resp
    end

    def respond_to_fight(m)
      battle = $Game.current_battle
      # get a mob
      mob = battle.mobs.first

      # lookup users dmg rating
      user_dmg_rating = 1

      # apply_attack to mob's HP
      mob.hp -= user_dmg_rating
      mob.save

      m.reply "#{m.user.nick} dmgs goblin for 1pt"

      # announce if mob dies
      if mob.hp <= 0
        mob.delete
        m.reply ">> The #{mob.name} is slain! <<"
      end
    end

    def respond_to_help(m)
      m.user.send "This is a fun group based adventure game where monsters show up and you fight them and have wonderful adventures"
    end
  end
  Cinch::Callback.include(AdventureChannel::Controller)
end
