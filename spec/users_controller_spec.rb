require "rails_helper"

describe UsersController, type: :controller do
  render_views

  it "deletes user" do
    
    match = Match.new(team_1_name: "Lech", team_2_name: "Warta", match_result: "0:0")
    match.save!

    user = User.new(username: "Olaf", goals_count: 0, match_count: 1)
    user.save!

    matches_user = MatchesUser.new
    matches_user.user = user
    matches_user.match = match
    matches_user.save!

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

  it "deletes match" do
    match = Match.new(team_1_name: "Lech", team_2_name: "Warta", match_result: "0:0")
    match.save!

    user = User.new(username: "Olaf", goals_count: 0, match_count: 1)
    user.save!

    matches_user = MatchesUser.new
    matches_user.user = user
    matches_user.match = match
    matches_user.save!


    get :match_destroy, params: { match_id: match.id }

    expect(Match.count).to eq 0
  end


end