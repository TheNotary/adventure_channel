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
      expect(@user.sum_property_of_items("defense")).to eq 2
    end

    it "should know its overal defense" do
      expect(@user.defense).to eq 3
    end

    it "should know its attack" do
      expect(@user.atk).to eq 4
    end

    it "should know it's base strength" do
      expect(@user.strength).to eq 1
    end

    it "should know it's effective strength" do
      expect(@user.effective_strength).to eq 2
    end



    it "should know its stats" do
      expected_stats = <<-EOF
Dmg     1 | Def       3 |  str  1,   sta  1,   agi  1,   int  1,   spi  1
MgkAtk  0 | MgkDef    0 | Atk 4 | Precision  0 | Eva  0 | MgkEva  0
Lvl     1 | Nxtlvl  200 | Exp       1 | Resistances:   0wht,   0drk,  50cld,   0fire,   0thnd,   0psn
      EOF
      stats_printout = @user.print_stats
      expect(stats_printout).to eq expected_stats
    end
  end


  describe "battle mechanics" do

    it "can account for an attacker missing target"

    it "can perform crits"


  end

  # see can_apply_earned_attribute? in user.rb
  it "can_apply_earned_attributes after leveling"

  it "can calculate damage against a mob" do
    # FIXME: test fails because of flaw in calculate_damage_against
    expect(@user.calculate_damage_against(@mob)).to eq 2
  end


end
