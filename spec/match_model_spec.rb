require "rails_helper"

describe Match, type: :model do

  it "saves match" do
    home_squad = Squad.new
    home_squad.team_name = "Lech"
    team = Team.new
    team.name = home_squad.team_name
    team.save!
    home_squad.team = team
    home_squad.save!
    away_squad = Squad.new
    away_squad.team_name = "Legia"
    team = Team.new
    team.name = away_squad.team_name
    team.save!
    away_squad.team = team
    away_squad.save!
    match = Match.new
    match.home_squad = home_squad
    match.away_squad = away_squad
    match.match_result = "3:1"

    expect(match.save).to be true
  end

  it "ensures match_result presence" do
    home_squad = Squad.new
    home_squad.team_name = "Lech"
    team = Team.new
    team.name = home_squad.team_name
    team.save!
    home_squad.team = team
    home_squad.save!
    away_squad = Squad.new
    away_squad.team_name = "Legia"
    team = Team.new
    team.name = away_squad.team_name
    team.save!
    away_squad.team = team
    away_squad.save!
    match = Match.new
    match.home_squad = home_squad
    match.away_squad = away_squad
    match.match_result = ""

    expect(match.save).to be false
  end

end