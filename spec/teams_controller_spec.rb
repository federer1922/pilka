require "rails_helper"

describe TeamsController, type: :controller do
  render_views

  it "shows team" do
    home_squad = Squad.new
    home_squad.team_name = "Lech"
    team = Team.new
    team.name = home_squad.team_name
    home_squad.team = team
    home_squad.save!
    
    away_squad = Squad.new
    away_squad.team_name = "Warta"
    team = Team.new
    team.name = away_squad.team_name
    away_squad.team = team
    away_squad.save!

    match = Match.new
    match.match_result = "0:0"
    match.home_squad = home_squad
    match.away_squad = away_squad
    match.save!

   # user = User.new(username: "Olaf", goals_count: 0, match_count: 0)
   # user.save!

   # player = Player.new
   # player.user = user
   # player.squad = home_squad
   # player.goals_scored = 0
   # player.save!

    get :show, params: { team_id: team.id }

    expect(response).to have_http_status(200)
  end
end