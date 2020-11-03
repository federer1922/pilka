require "rails_helper"

describe UsersController, type: :controller do
  render_views

  it "deletes user" do
    user = User.new(username: "Olaf", goals_count: 0, match_count: 0)
    user.save!

    get :destroy, params: { user_id: user.id }

    expect(User.count).to eq 0
  end

  it "adds goal" do
    user = User.new(username: "Olaf", goals_count: 0, match_count: 0)
    user.save!

    get :add_goal, params: { user_id: user.id }

    expect(user.reload.goals_count).to eq 1
  end

  it "subtracts goal" do
    user = User.new(username: "Olaf", goals_count: 1, match_count: 0)
    user.save!

    get :subtract_goal, params: { user_id: user.id }

    expect(user.reload.goals_count).to eq 0
  end

  it "adds match" do
    user = User.new(username: "Olaf", goals_count: 0, match_count: 0)
    user.save!

    get :add_match, params: { user_id: user.id }

    expect(user.reload.match_count).to eq 1
  end

  it "subtracts match" do
    user = User.new(username: "Olaf", goals_count: 0, match_count: 1)
    user.save!

    get :subtract_match, params: { user_id: user.id }

    expect(user.reload.match_count).to eq 0
  end

end