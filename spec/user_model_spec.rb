require "rails_helper"

describe User, type: :model do

  it "saves user" do
    user = User.new(username: "Olaf", goals_count: 0, match_count: 0)

    expect(user.save).to be true
  end

  it "ensures username presence" do
    user = User.new(username: "", goals_count: 0, match_count: 0)

    expect(user.save).to be false
  end

  it "is not valid without username" do
    user = User.new(username: nil)
    
    expect(user).to_not be_valid
  end
end