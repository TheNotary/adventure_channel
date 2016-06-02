require 'spec_helper'

describe AdventureChannel::AdventureGame::Game do
  it "can be instantiated" do
    @game = Game.new
    expect(@game.status).to eq :idle
  end

  it "can enter into a battle" do
    @game = Game.new
    @game.start_battle
    expect(@game.status).to eq :in_battle
  end
end
