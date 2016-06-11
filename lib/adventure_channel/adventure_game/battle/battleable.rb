require 'adventure_channel/adventure_game/battle/battle_mathematics'
require 'adventure_channel/adventure_game/battle/stats_helper'

AdventureChannel::AdventureGame::Resistances = [:white, :dark, :cold, :fire, :thunder, :poison]
AdventureChannel::AdventureGame::BasicCombatStats = [:strength, :stamina, :agility, :intelligence, :spirit]
AdventureChannel::AdventureGame::CompositCombatStats = [:atk, :defense, :mgk_atk, :mgk_def]
AdventureChannel::AdventureGame::PercentageCombatStats = [:pre, :eva, :mgk_eva]


# inheritance must work through this mixin pattern (call from inheriting classes)
def battleable
  include AdventureChannel::AdventureGame::BattleMathematics
  include AdventureChannel::AdventureGame::StatsHelper

  attribute :name;       index :name

  # battlestatly...
  attribute :exp, lambda { |x| x.to_i }
  attribute :attribues_for_level, lambda { |x| x.to_i }
  attribute :hp, lambda { |x| x.to_i }
  attribute :mp, lambda { |x| x.to_i }
  attribute :max_hp, lambda { |x| x.to_i }
  attribute :max_mp, lambda { |x| x.to_i }

  attribute :strength, lambda { |x| x.to_i }
  attribute :stamina, lambda { |x| x.to_i }
  attribute :agility, lambda { |x| x.to_i }
  attribute :intelligence, lambda { |x| x.to_i }
  attribute :spirit, lambda { |x| x.to_i }

  attribute :attack_base, lambda { |x| x.to_i }
  attribute :defense_base, lambda { |x| x.to_i }
  attribute :magic_defense_base, lambda { |x| x.to_i }

  attribute :special_permenant_modifiers # eg { special_permenant_modifiers: [ "jaunt_quest_completed": [ modify-resist_fire": "10", "modify-title": "Super Cool Dude"] }
  attribute :status_effects

  attribute :abilities


  list :inventory, :Item

  attribute :equipment_id
  reference :equipment, :Loadout

  #####################
  # One-Liner Methods #
  #####################
  #
  # Use the `define_method` convention to define one-liner methods where actual
  # logic is conducted elsewhere.  This leaves breadcrums behind for people
  # new to ruby.

  define_method(:level) { level_calculation }
  define_method(:attribues_for_level) { attribues_for_level_calculation }

  # TODO: create functions effective_agility that takes into account modifiers
  def atk_from_stats
    (strength * 2) + (agility)
  end


  AdventureChannel::AdventureGame::StatsHelper.resistence_stat_definitions # e.g. resist_cold

  # This allows battleable objects to print their resistences stats
  AdventureChannel::AdventureGame::StatsHelper.resistances_printer  # e.g. p_cold

  
  AdventureChannel::AdventureGame::StatsHelper.effective_combat_stat_definitions


  # TODO: move to mathematics
  def calculate_damage_against(defender)
    # binding.pry
    # FIXME: change this to defender.defense
    dmg = atk - defense
  end

  # [Composite Stat]
  # Attack is special because it is both a base stat inherint to the battler,
  # but also a calculation _based on other stats_ and of course direct
  # modifiers...  a composite stat
  def atk
    attack_base + sum_property_of_items("atk") + atk_from_stats
  end

  # [Composite Stat]
  def defense
    defense_base + sum_property_of_items("defense") # + defense_from_stats
  end

  def def_from_items
    defense_sum = 0

    equipment.pieces.each do |piece_sym|
      piece = equipment.send(piece_sym)
      defense_sum += JSON.parse(piece.meta)["defense"].to_i unless piece.nil?
    end

    defense_sum
  end

  def sum_property_of_items(property)
    sum = 0

    equipment.pieces.each do |piece_sym|
      piece = equipment.send(piece_sym)
      sum += JSON.parse(piece.meta)[property].to_i unless piece.nil?
    end

    sum
  end

  # TODO: when this gets implemented, I think status_effects should store a
  # datastructure that looks like...
  # { status_effects: [ { spell_fortitude: { expires_at: "SOMETIME", modify-def: "2" } } ]
  def collect_from_status_effects(key)
    # s = JSON.parse(status_effects)
  end


  # [stat] precision, likelyhood of attack landing on target
  def pre
    '%2s' % 0
  end

  # [stat] evasion, likelyhood of dodging attack from attacker
  def eva
    '%2s' % 0
  end

  # magic_evasion
  def mgk_eva
    '%2s' % 0
  end

  # [stat] magic_attack, dmg of spell based attack
  def mgk_atk
    0
  end

  # magic_defense
  def mgk_def
    '%2s' % 0
  end





  # TODO: finish this when you test leveling up
  def can_apply_earned_attribute?
    # sum_of_stats > attribues_for_level + bonus_attributes
  end


end



module AdventureChannel
  module AdventureGame
  end
end
