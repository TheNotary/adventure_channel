require 'spec_helper'

describe AdventureChannel::AdventureGame::Battle do
  it "can be instantiated" do
    @battle = Battle.new
    # expect(@battle.status).to eq :idle
  end

  it "can have mobs spawned into a battle" do
    @battle = Battle.new
    @battle.spawn_mob(Mob.new(name: "Green Goblin", hp: 10))

    expect(@battle.mobs.count).to eq 1
  end
end
