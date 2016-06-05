# inheritance must work through this mixin pattern (call from inheriting
# classes)

def battleable
  attribute :name;       index :name
  attribute :exp, lambda { |x| x.to_i }
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


  list :inventory, :Item

  attribute :equipment_id
  reference :equipment, :Loadout

  def calculate_damage_against(defneder)
    # dmg = user

    binding.pry
  end

  def attack
  end

  def defense
    # look at inventory items
    all_def_from_base = defense_base
    all_def_from_items = def_from_items
    all_def_from_modifiers = nil
  end

  def def_from_items
    defense_c = 0

    equipment.pieces.each do |piece_sym|
      piece = equipment.send(piece_sym)
      defense_c += JSON.parse(piece.meta)["def"].to_i unless piece.nil?
    end

    defense_c
  end


  def precision
  end

  def evasion
  end

  def magic_defense
  end

  def magic_evasion
  end

  def level
    ( 0.5 * Math.sqrt(exp) ).ceil
  end

end


module AdventureChannel
  module AdventureGame
  end
end
