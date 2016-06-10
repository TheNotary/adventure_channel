require 'adventure_channel/adventure_game/battle/battle_mathematics'

# inheritance must work through this mixin pattern (call from inheriting
# classes)
def battleable
  include AdventureChannel::AdventureGame::BattleMathematics

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

  attribute :defense_base, lambda { |x| x.to_i }
  attribute :attack_base, lambda { |x| x.to_i }
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


  def calculate_damage_against(defender)
    dmg = attack - defense
  end

  def attack
    attack_base + sum_property_of_items("atk") + attack_from_stats
  end
  alias atk attack

  def defense
    # all_def_from_modifiers = nil
    defense_base + sum_property_of_items("def")
  end

  def def_from_items
    defense_sum = 0

    equipment.pieces.each do |piece_sym|
      piece = equipment.send(piece_sym)
      defense_sum += JSON.parse(piece.meta)["def"].to_i unless piece.nil?
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

  # TODO: create functions effective_agility that takes into account modifiers
  def attack_from_stats
    (strength * 2) + (agility)
  end

  # TODO: when this gets implemented, I think status_effects should store a
  # datastructure that looks like...
  # { status_effects: [ { spell_fortitude: { expires_at: "SOMETIME", modify-def: "2" } } ]
  def collect_from_status_effects(key)
    # s = JSON.parse(status_effects)
  end


  def precision
    '%2s' % 0
  end
  alias pre precision

  def evasion
    '%2s' % 0
  end
  alias eva evasion

  def magic_attack
    0
  end
  alias mgk_atk magic_attack

  def mgk_atk_p
    '%2s' % magic_attack
  end

  def magic_defense
    '%2s' % 0
  end
  alias mgk_def magic_defense

  def magic_evasion
    '%2s' % 0
  end
  alias mgk_eva magic_evasion





  # weapon damage
  def wpn_dmg
    1
  end
  def wpn_dmg_p
    '%3s' % wpn_dmg
  end



  def level_p; '%3s' % level; end

  def attribues_for_level
    attributes = 6 + level * 4
  end

  # TODO: finish this when you test leveling up
  def can_apply_earned_attribute?
    # sum_of_stats > attribues_for_level + bonus_attributes
  end

  # TODO:  refactor: new file resistable
  def resist_cold
    '%4s' % (sum_property_of_items("resist_cold"))
  end
  alias r_cld resist_cold

  def resist_fire
    '%4s' % sum_property_of_items("resist_fire")
  end
  alias r_fire resist_fire

  def resist_white
    '%4s' % sum_property_of_items("resist_white")
  end
  alias r_wht resist_white

  def resist_dark
    '%4s' % sum_property_of_items("resist_dark")
  end
  alias r_drk resist_dark

  def resist_thunder
    '%4s' % sum_property_of_items("resist_thunder")
  end
  alias r_thnd resist_thunder

  def resist_poison
    '%4s' % sum_property_of_items("resist_poison")
  end
  alias r_psn resist_poison


  # this should reallly get it's own view... maybe...
  def print_stats
    <<-EOF
Dmg   #{wpn_dmg_p} | Def       #{defense} |  str  #{strength},   str  #{strength},   sta  #{stamina},   agi  #{agility},   int  #{intelligence},   spi  #{spirit}
MgkAtk #{mgk_atk_p} | MgkDef   #{mgk_def} | Atk #{atk} | Precision #{pre} | Eva #{eva} | MgkEva #{mgk_eva}
Lvl   #{level_p} | Nxtlvl  200 | Exp #{'%7s' % exp} | Resistances:#{r_wht}wht,#{r_drk}drk,#{r_cld}cld,#{r_fire}fire,#{r_thnd}thnd,#{r_psn}psn
    EOF
  end

end



module AdventureChannel
  module AdventureGame
  end
end
