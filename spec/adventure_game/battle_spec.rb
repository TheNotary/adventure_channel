require 'spec_helper'

describe AdventureChannel::AdventureGame::Game do
  before :each do
    @game = Game.new
    @user = User.find_or_create_user("testc")
  end

  it "can be instantiated" do
    expect(@game.status).to eq :idle
  end

  describe "battle stuff" do
    before :each do
      @game.start_battle
      @battle = @game.current_battle
    end

    it "can enter into a battle" do
      expect(@game.status).to eq :in_battle
    end

    it "can start the battle with a default mob" do
      expect(@battle.mobs.count).to eq 1
    end

    it "can add partisipants to the battle when they perform actions" do
      @battle.fight(attacker: @user)

      expect(@battle.participants.count).to eq(1)
      binding.pry
    end
  end
end
