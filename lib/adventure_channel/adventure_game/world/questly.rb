require 'adventure_channel/adventure_game/world/quest'

# A questly object is one that can accomplish quests and maintain a quest journal
def questly
  list :current_quest_journal, :Quest
  list :completed_quest_journal, :Quest
end
