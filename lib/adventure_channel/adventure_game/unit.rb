# inheritance must work through this mixin pattern (call from inheriting
# classes)

def battleable
  attribute :name;       index :name
  attribute :hp, lambda { |x| x.to_i }
  attribute :mp, lambda { |x| x.to_i }
  list :inventory, :Item

  reference :equipment, :Loadout
end


module AdventureChannel
  module AdventureGame
  end
end
