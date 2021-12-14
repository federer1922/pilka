require "rails_helper"

describe PlayersController, type: :controller do
  render_views

  it "shows error if user not chosen" do
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

    post :create, params: { squad_id: home_squad.id, match_id: match.id }

    expect(Player.count).to eq 0
    expect(flash[:alert]).to eq "Player must be chosen"

  end

  it "adds player to squad" do
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

    post :create, params: { squad_id: home_squad.id, user_id: user.id, match_id: match.id }

    expect(Player.count).to eq 1
    player = Player.last
    expect(player.squad).to eq home_squad
    expect(player.squad.team_name).to eq "Lech"
    expect(user.reload.match_count).to eq 1
  end

  it "destroys player" do
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

    user = User.new(username: "Olaf", goals_count: 10, match_count: 14)
    user.save!

    player = Player.new
    player.user = user
    player.squad = home_squad
    player.goals_scored = 3
    player.save!

    delete :destroy, params: { player_id: player.id, squad_id: home_squad.id, match_id: match.id }
    
    expect(Player.count).to eq 0
    expect(user.reload.goals_count).to eq 7
    expect(user.reload.match_count).to eq 13
  end

  it "adds goal scored" do
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
    
    user = User.new(username: "Olaf", goals_count: 2, match_count: 4)
    user.save!
    
    player = Player.new
    player.squad = home_squad
    player.user = user
    player.goals_scored = 0
    player.save!

    put :add_goal_scored, params: {player_id: player.id, match_id: match.id}
    
    expect(player.reload.goals_scored).to eq 1
    expect(user.reload.goals_count). to eq 3
  end

  it "subracts goal scored" do
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
    
    user = User.new(username: "Olaf", goals_count: 4, match_count: 0)
    user.save!
    
    player = Player.new
    player.squad = home_squad
    player.user = user
    player.goals_scored = 3
    player.save!

    put :subtract_goal_scored, params: {player_id: player.id, match_id: match.id}
    
    expect(player.reload.goals_scored).to eq 2
    expect(user.reload.goals_count). to eq 3
  end

  it "does not subracts goal from goals count if goals scored 0" do
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
    
    user = User.new(username: "Olaf", goals_count: 4, match_count: 0)
    user.save!
    
    player = Player.new
    player.squad = home_squad
    player.user = user
    player.goals_scored = 1
    player.save!

    put :subtract_goal_scored, params: {player_id: player.id, match_id: match.id}
    put :subtract_goal_scored, params: {player_id: player.id, match_id: match.id}
    
    expect(player.reload.goals_scored).to eq 0
    expect(user.reload.goals_count). to eq 3
  end
end