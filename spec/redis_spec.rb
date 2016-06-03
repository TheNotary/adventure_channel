require 'spec_helper'

$redis = AdventureChannel::init_redis

describe "Redis" do

  before :each do
    @user = User.spawn_for_new_player(:name => "me")
  end

  after :each do
    @user.delete
  end

  it "can serialize a user with all it's things" do
    user = @user

    user.hp = 10
    user.save

    u = User.find(name: "me").first
    expect(u.name).to eq user.name
    expect(u.hp).to eq user.hp
  end


  it "can have associations" do
    user = @user

    item = Item.create(:name => "Jaggedly sharp e-waste specimen")
    user.inventory.push item

    user = User.find(name: @user.name).first

    expect(user.inventory.count).to eq(1)
    expect(user.inventory.first).to eq(item)
  end

  it "allows users to have equipment" do
    user = @user

    pants = Item.create(:name => "Some sharp looking pants")

    user.equipment.legs = pants
    user.equipment.save
    user.save

    user = User.find(name: @user.name).first
    expect(user.equipment.legs).to eq(pants)
  end

  it "allows funishing equipment to new players" do
    user = @user

    # binding.pry
  end


end
