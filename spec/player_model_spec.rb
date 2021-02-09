require "rails_helper"

describe Player, type: :model do

  it "saves player" do
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
    user.match_count = user.match_count + 1
    user.save

    expect(player.save).to be true
  end

  it "ensures goals_scored can not be less than 0" do
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
    player.goals_scored = -2
    user.match_count = user.match_count + 1
    user.save!

    expect(player.save).to be false
  end

  it "it ensures user.username is equal to player.username" do
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
    player.goals_scored = 1
    user.match_count = user.match_count + 1
    user.save!
    player.save!
  
    expect(user.username).to eq player.username
  end
end