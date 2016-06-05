require 'spec_helper'

describe AdventureChannel::AdventureGame::User do
  before :each do
    @game = Game.new
    @battle = @game.battle
    @user = User.find_or_create_user("testc")
    @mob = Mob.create(name: 'Green Goblin', hp: 20)
  end



  describe "attributes" do

    it "should know its level" do
      expect(@user.level).to eq 1
    end

    it "should know its defesive value from equipment" do
      expect(@user.def_from_items).to eq 1
    end

    it "should know its overal defense" do
      expect(@user.defense).to eq 1
    end


    it "should know its attack" do
      expect(@user.atk).to eq 1
    end

    it "should know its stats" do
    end
  end


  it "can calculate damage against a mob" do
    dmg = @user.calculate_damage_against(@mob)
    expect(dmg).to eq 1
  end


end
