require 'spec_helper'

describe AdventureChannel::AdventureGame::Mob do
  before :each do
    @game = Game.new
    @battle = @game.battle
    @user = User.find_or_create_user("testc")
    @mob = Mob.find(code: "mob-0001")
    @mob = Mob.create(name: 'Green Goblin', hp: 20)
  end

  it "should be able to be spawned given a code and a level"

  it "should have decent stats compared to users of a given level"

  it "should be able to use it's mob moves on users" do
    # do this next
    binding.pry
  end

end
