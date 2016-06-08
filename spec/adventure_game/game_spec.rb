require 'spec_helper'

describe AdventureChannel::AdventureGame::Battle do
  it "can be instantiated" do
    @battle = Battle.new
    expect(@battle.status).to eq :idle
  end

  it "can have mobs spawned into a new battle" do
    @battle = Battle.new
    @battle.start(mobs: {code: "mob-0001", hp: 10})

    expect(@battle.mobs.count).to eq 1
  end

  it "can have mobs spawn into an existing battle" do
    @battle = Battle.new
    @battle.start(mobs: {code: "mob-0001", hp: 10})

    @battle.spawn_new_mob(code: "mob-0001", hp: 10)

    expect(@battle.mobs.count).to eq 2
  end

  it "allows an admin to set hackerspace fields like website, mailinglist, address, GPS, etc."

  it "allows players to query hackerspace fields like website, mailinglist, address, GPS, etc."

end
