module AdventureChannel
  module Controller
    # include AdventureChannel::AdventureGame

    def respond_to_inventory(m)
      resp = User.find_or_create_user(m.user.nick).export_inventory
      m.user.send resp
    end

    def respond_to_equipment(m)
      resp = User.find_or_create_user(m.user.nick).export_equipment
      m.user.send resp
    end

    def respond_to_status(m)
      resp = "~~ #{m.user.name} ~~\n"
      resp << User.find_or_create_user(m.user.nick).export_status
      m.user.send resp
    end

    def respond_to_check(m)
      # lookup another user's equpment
      m.user.send "I can't lookup other player's equpment because no one implemented this function"
    end

    def respond_to_join(m)
    end

    # This is something that the backend signlals to the IRC client to start a
    # new battle
    def respond_to_initiate_battle(m)
      if authorization_denied?(m)
        m.user.send "Fatal:  Authorization denied" && return
      end

      resp = $Game.battle.start
      m.user.send resp
    end

    def respond_to_fight(m)
      battle = $Game.battle

      # get user
      irc_user = m.user
      attacker = User.find_or_create_user(irc_user.nick)

      responses = battle.fight(attacker: attacker)

      m.reply responses[:fight_statistic].join("\n")
      m.user.send response[:effects_for_attacker].join("\n")

      # TODO: this should get implemented in the future
      # atm, humans can only fight bots, not other humans..... hmmm.....
      # so we won't reply to a bot
      # m.reply response[:effects_for_defender].join("\n")

      # announce if mob dies
    end


    def respond_to_help(m)
      m.user.send "This is a fun group based adventure game where monsters show up and you fight them and have wonderful adventures"
    end
  end
  Cinch::Callback.include(AdventureChannel::Controller)
end
