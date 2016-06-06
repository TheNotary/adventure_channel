require 'spec_helper'

describe AdventureChannel::AdventureGame::Mob do

  it "should be able to generate a mob via a slick API" do
    mob = Mob.spawn(code: "mob-0001", hp: 10, strength: 9)
    expect(mob.strength).to eq 9
    expect(mob.hp).to eq 10
  end

  it "should be able to infer max_mp/ max_hp from hp and mp when given" do
    mob = Mob.spawn(code: "mob-0001", hp: 10, mp: 11)
    expect(mob.max_hp).to eq 10
    expect(mob.max_mp).to eq 11
  end


  describe do
    before :each do
      @game = Game.new
      @battle = @game.battle
      @user = User.find_or_create_user("testc")
      @mob = Mob.find(code: "mob-0001").first
      # @mob = Mob.create(name: 'Green Goblin', hp: 20)
    end



    it "should be able to be spawned given a code and a level"

    it "should have decent stats compared to users of a given level"

    it "should be able to use it's mob moves on users" do
      # do this next
      move = @mob.determine_next_action
      expect(move).to eq "Goblin Punch"

    end
  end

end
