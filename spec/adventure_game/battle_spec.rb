require 'spec_helper'

describe AdventureChannel::AdventureGame::Game do
  it "can be instantiated" do
    $Game = Game.new
    expect($Game.status).to eq :idle
  end

  it "can enter into a battle" do
    $Game = Game.new
    $Game.start_battle
    expect($Game.status).to eq :in_battle
  end

  it "can add partisipants to the battle when they perform actions" do
    # $Game = Game.new

  end
end
