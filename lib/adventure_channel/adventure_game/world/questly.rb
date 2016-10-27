require 'adventure_channel/adventure_game/world/quest'

module AdventureChannel
  module AdventureGame

    # Questly
    #
    # A questly game object will keep a quest jounal, be able to accept new
    # quests, and complete them.
    module Questly

      def self.included(base)
        base.class_eval do
          list :current_quest_journal, :Quest
          list :completed_quest_journal, :Quest
        end
      end
    end
  end
end
