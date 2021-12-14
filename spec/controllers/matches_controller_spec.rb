require "rails_helper"

describe MatchesController, type: :controller do
  render_views

  it "creates match" do
    post :create, params: { match: { home_team_name: "Lech", away_team_name: "Warta", home_score: 0, away_score: 0 } }
    post :create, params: { match: { home_team_name: "Warta", away_team_name: "Legia", home_score: 1, away_score: 0 } }
    
    expect(Match.count).to eq 2
    match = Match.first
    expect(match.home_squad.team_name).to eq "Lech"
    expect(match.away_squad.team_name).to eq "Warta"
    expect(match.match_result). to eq "0:0"
    match = Match.last
    expect(match.home_squad.team_name).to eq "Warta"
    expect(match.away_squad.team_name).to eq "Legia"
    expect(match.match_result).to eq "1:0"
    expect(Team.count).to eq 3 
  end

  it "deletes match" do
    home_squad = Squad.new
    home_squad.team_name = "Lech"
    team = Team.new
    team.name = home_squad.team_name
    team.save!
    home_squad.team = team
    home_squad.save!
    
    away_squad = Squad.new
    away_squad.team_name = "Warta"
    team = Team.new
    team.name = away_squad.team_name
    team.save!
    away_squad.team = team
    away_squad.save!

    match = Match.new
    match.match_result = "0:0"
    match.home_squad = home_squad
    match.away_squad = away_squad
    match.save!

    user_1 = User.new(username: "Olaf", goals_count: 5, match_count: 4)
    user_1.save!

    user_2 = User.new(username: "Arek", goals_count: 3, match_count: 2)
    user_2.save!

    player = Player.new
    player.user = user_1
    player.squad = home_squad
    player.goals_scored = 1
    player.save!

    player = Player.new
    player.user = user_2
    player.squad = away_squad
    player.goals_scored = 2
    player.save!

    delete :destroy, params: { match_id: match.id }

    expect(Match.count).to eq 0
    expect(Squad.count).to eq 0
    expect(Player.count).to eq 0
    expect(Team.count).to eq 2
    expect(user_1.reload.goals_count).to eq 4
    expect(user_1.reload.match_count).to eq 3
    expect(user_2.reload.goals_count).to eq 1
    expect(user_2.reload.match_count).to eq 1
  end

  it "shows" do
    home_squad = Squad.new
    home_squad.team_name = "Lech"
    team = Team.new
    team.name = home_squad.team_name
    team.save!
    home_squad.team = team
    home_squad.save!
    
    away_squad = Squad.new
    away_squad.team_name = "Warta"
    team = Team.new
    team.name = away_squad.team_name
    team.save!
    away_squad.team = team
    away_squad.save!

    match = Match.new
    match.match_result = "0:0"
    match.home_squad = home_squad
    match.away_squad = away_squad
    match.save!

    user = User.new(username: "Olaf", goals_count: 0, match_count: 0)
    user.save!

    player = Player.new
    player.user = user
    player.squad = home_squad
    player.goals_scored = 0
    player.save!

    get :show, params: { match_id: match.id }

    expect(response).to have_http_status(200)
  end
end