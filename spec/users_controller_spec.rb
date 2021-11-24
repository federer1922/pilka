require "rails_helper"

describe UsersController, type: :controller do
  render_views

  it "creates user" do
    get :create, params: { username: "Olaf" }
    get :create, params: { username: "Olaf" }
    get :create, params: { username: "Wojtek" }

    user = User.first
    expect(user.username).to eq "Olaf"
    user = User.last
    expect(user.username).to eq "Wojtek"
    expect(User.count).to eq 2
  end

  it "does not create a user without the username" do
    get :create, params: { username: nil }

    expect(flash[:alert]).to be_present
    expect(User.count).to eq 0
  end

  it "deletes user" do
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

    get :destroy, params: { user_id: user.id }

    expect(User.count).to eq 0
  end

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

    get :add_player_to_squad, params: { squad_id: home_squad.id, match_id: match.id }

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

    get :add_player_to_squad, params: { squad_id: home_squad.id, user_id: user.id, match_id: match.id }

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

    get :destroy_player, params: { player_id: player.id, squad_id: home_squad.id, match_id: match.id }
    
    expect(Player.count).to eq 0
    expect(user.reload.goals_count).to eq 7
    expect(user.reload.match_count).to eq 13
  end
end