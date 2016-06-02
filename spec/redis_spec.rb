require 'spec_helper'

$redis = AdventureChannel::init_redis

describe "Redis" do

  it "can serialize a user with all it's things" do
    user = User.create(:name => "me")

    # Give user items in inventory
    # Give user equipment


    binding.pry


    # $redis.set
  end


  # FIXME: The below spec requires that when you create users, you push them
  # to @game.users, and we override the push function there to be in charge
  # of setting the ID
  it "will generate a unique ID for new users"


end
