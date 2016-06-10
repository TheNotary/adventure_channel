require 'spec_helper'

describe AdventureChannel::AdventureGame::Battle do
  before :each do
    @game = Game.new
    @battle = @game.battle
    @user = User.find_or_create_user("testc")
  end

  it "can be instantiated" do
    expect(@battle.status).to eq :idle
  end

  describe "battle stuff" do
    before :each do
      @game.battle.start
    end

    it "can enter into a battle" do
      expect(@battle.status).to eq :in_battle
    end

    it "can generate a battle start announcement" do
      script = "~ A monster has appeared ~\n"
      script += "> lvl 0 Green Goblin"

      expect(@battle.battle_start_announcement).to eq script
    end

    it "can start the battle with a default mob" do
      expect(@battle.mobs.count).to eq 1
    end

    it "can add partisipants to the battle when they perform acts" do
      @battle.fight(attacker: @user)

      expect(@battle.participants.count).to eq(1)
    end

    describe "user variables" do

      it "can calculate a good mob level for the users in game"

      it "can cap a users level if there's a user who's way over level"



      
    end
  end
end
