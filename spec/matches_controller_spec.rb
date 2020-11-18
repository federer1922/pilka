require "rails_helper"

describe MatchesController, type: :controller do
  render_views

  it "creates match" do

    match = Match.new(team_1_name: "Lech", team_2_name: "Warta", match_result: "0:0")
    match.save!

    expect(match.team_1_name).to eq "Lech"
    expect(match.team_2_name).to eq "Warta"
    expect(match.match_result). to eq "0:0"
    expect(Match.count).to eq 1
  end

  it "deletes match" do
    match = Match.new(team_1_name: "Lech", team_2_name: "Warta", match_result: "0:0")
    match.save!

    user = User.new(username: "Olaf", goals_count: 0, match_count: 1)
    user.save!

    player = Player.new
    player.user = user
    player.match = match
    player.save!

    get :match_destroy, params: { match_id: match.id }

    expect(Match.count).to eq 0
  end

  it "shows" do
    match = Match.new(team_1_name: "Lech", team_2_name: "Warta", match_result: "0:0")
    match.save!
    user = User.new(username: "Olaf", goals_count: 0, match_count: 0)
    user.save!

    player = Player.new
    player.user = user
    player.match = match
    player.save!

    get :show, params: { match_id: match.id }

    expect(response).to have_http_status(200)

  end

  it "adds goal scored" do
    match = Match.new(team_1_name: "Lech", team_2_name: "Warta", match_result: "0:0")
    match.save!
    
    user = User.new(username: "Olaf", goals_count: 0, match_count: 0)
    user.save!
    
    player = Player.new
    player.match = match
    player.user = user
    player.goals_scored = 0
    player.save  

    get :add_goal_scored, params: {player_id: player.id, match_id: match.id}
    
    expect(player.reload.goals_scored).to eq 1
    expect(user.reload.goals_count). to eq 1
  end

end