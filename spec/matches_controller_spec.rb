require "rails_helper"

describe MatchesController, type: :controller do
  render_views

  it "creates match" do
    get :match_create, params: { home_team_name: "Lech", away_team_name: "Warta", match_result: "0:0"  }
    
    expect(Match.count).to eq 1
    match = Match.last
    expect(match.home_squad.team_name).to eq "Lech"
    expect(match.away_squad.team_name).to eq "Warta"
    expect(match.match_result). to eq "0:0"
  end

  it "deletes match" do
    home_squad = Squad.new
    home_squad.team_name = "Lech"
    home_squad.save!
    
    away_squad = Squad.new
    away_squad.team_name = "Warta"
    away_squad.save!

    match = Match.new
    match.match_result = "0:0"
    match.home_squad = home_squad
    match.away_squad = away_squad
    match.save!

    user = User.new(username: "Olaf", goals_count: 0, match_count: 1)
    user.save!

    player = Player.new
    player.user = user
    player.squad = home_squad
    player.match = match # to do usunięcie kolumny match_id z tabeli players
    player.goals_scored = 0
    player.save!

    get :match_destroy, params: { match_id: match.id }

    expect(Match.count).to eq 0
    expect(Squad.count).to eq 0
    expect(Player.count).to eq 0
  end

  it "shows" do
    home_squad = Squad.new
    home_squad.team_name = "Lech"
    home_squad.save!
    
    away_squad = Squad.new
    away_squad.team_name = "Warta"
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
    player.match = match
    player.goals_scored = 0
    player.save!

    get :show, params: { match_id: match.id }

    expect(response).to have_http_status(200)
  end

  it "adds goal scored" do
    home_squad = Squad.new
    home_squad.team_name = "Lech"
    home_squad.save!
    
    away_squad = Squad.new
    away_squad.team_name = "Warta"
    away_squad.save!

    match = Match.new
    match.match_result = "0:0"
    match.home_squad = home_squad
    match.away_squad = away_squad
    match.save!
    
    user = User.new(username: "Olaf", goals_count: 0, match_count: 0)
    user.save!
    
    player = Player.new
    player.match = match
    player.squad = home_squad
    player.user = user
    player.goals_scored = 0
    player.save!

    get :add_goal_scored, params: {player_id: player.id, match_id: match.id}
    
    expect(player.reload.goals_scored).to eq 1
    expect(user.reload.goals_count). to eq 1
  end

  it "subracts goal scored" do
    home_squad = Squad.new
    home_squad.team_name = "Lech"
    home_squad.save!
    
    away_squad = Squad.new
    away_squad.team_name = "Warta"
    away_squad.save!

    match = Match.new
    match.match_result = "0:0"
    match.home_squad = home_squad
    match.away_squad = away_squad
    match.save!
    
    user = User.new(username: "Olaf", goals_count: 4, match_count: 0)
    user.save!
    
    player = Player.new
    player.squad = home_squad
    player.match = match
    player.user = user
    player.goals_scored = 3
    player.save!

    get :subtract_goal_scored, params: {player_id: player.id, match_id: match.id}
    
    expect(player.reload.goals_scored).to eq 2
    expect(user.reload.goals_count). to eq 3
  end

  it "does not subracts goal from goals count if goals scored 0" do
    home_squad = Squad.new
    home_squad.team_name = "Lech"
    home_squad.save!
    
    away_squad = Squad.new
    away_squad.team_name = "Warta"
    away_squad.save!

    match = Match.new
    match.match_result = "0:0"
    match.home_squad = home_squad
    match.away_squad = away_squad
    match.save!
    
    user = User.new(username: "Olaf", goals_count: 4, match_count: 0)
    user.save!
    
    player = Player.new
    player.squad = home_squad
    player.match = match
    player.user = user
    player.goals_scored = 1
    player.save!

    get :subtract_goal_scored, params: {player_id: player.id, match_id: match.id}
    get :subtract_goal_scored, params: {player_id: player.id, match_id: match.id}
    
    expect(player.reload.goals_scored).to eq 0
    expect(user.reload.goals_count). to eq 3
  end

end