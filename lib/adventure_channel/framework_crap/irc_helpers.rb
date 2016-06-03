module AdventureChannel

  module IrcHelpers
    def has_authorization?(m)
      @requester ||= m.user.nick
      @auth_token ||= m.message[/^!initiate_battle (.+)/, 1]

      @auth_token == ENV['auth_token'] && ENV['admin_nicks'].downcase.split.include?(@requester.downcase)
    end

    def authorization_denied?(m)
      !has_authorization?(m)
    end
  end

  # make it so the helper methods are available within the Cinch callback handlers
  Cinch::Callback.include(AdventureChannel::IrcHelpers)
end
