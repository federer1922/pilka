require "rails_helper"

describe MatchesController, type: :controller do
  render_views

  it "creates match" do

    match = Match.new(team_1_name: "Lech", team_2_name: "Warta", match_result: "0:0")
    match.save!

    get :match_create, params: { team_1: match.team_1_name, team_2: match.team_2_name, result: match.match_result}

    expect(match.team_1_name).to eq "Lech"
    expect(match.team_2_name).to eq "Warta"
    expect(match.match_result). to eq "0:0"
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

  it "shows" do
    match = Match.new(team_1_name: "Lech", team_2_name: "Warta", match_result: "0:0")
    match.save!
    user = User.new(username: "Olaf", goals_count: 0, match_count: 0)
    user.save!

    matches_user = MatchesUser.new
    matches_user.user = user
    matches_user.match = match
    matches_user.save!

    get :show, params: { match_id: match.id }

    expect(Match.count). to eq 1

  end

end