require 'spec_helper'

describe AdventureChannel::AdventureGame::User do
  before :each do
    @game = Game.new
    @battle = @game.battle
    @user = User.find_or_create_user("testc")
    @mob = Mob.spawn(code: 'mob-0001', hp: 20)
  end



  describe "attributes" do

    it "should know its level" do
      expect(@user.level).to eq 1
    end

    it "should know its defesive value from equipment" do
      expect(@user.sum_property_of_items("defense")).to eq 2
    end

    it "should know its overal defense" do
      expect(@user.effective_defense).to eq 5
    end

    it "should know its attack" do
      expect(@user.atk_base).to eq 1
      expect(@user.effective_atk).to eq 6
    end

    it "should know it's base strength" do
      expect(@user.strength).to eq 1
    end

    it "should know it's effective strength" do
      expect(@user.effective_strength).to eq 2
    end

    it "should print it's effective mgk_defense" do
      expect(@user.p_mgk_defense).to eq " 1"
    end

    it "should know it's effective mgk_defense" do
      expect(@user.effective_mgk_defense).to eq 1
    end

    it "should know its stats" do
      expected_stats = <<-EOF
Dmg     1 | Def       5 |  str  1,   sta  1,   agi  1,   int  1,   spi  1
MgkAtk  0 | MgkDef    1 | Atk 6 | Precision  0 | Eva  0 | MgkEva  0
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

  describe "experiency" do

    it "can gain exp from slain mobs"
    it "can sum_allocated_attributes" do
      # FIXME: this will eventually allow a user to apply newly earned attributes
      # to health, strength, etc... stubbed now to test a refactor
      expect(@user.sum_allocated_attributes).to eq :stubbed
    end
    it "can level up and can_apply_earned_attributes?"
    it "actual attribute points can be assigned and saved"

  end


  it "can calculate damage against a mob" do
    expect(@user.calculate_damage_against(@mob)).to eq 4
  end


end
