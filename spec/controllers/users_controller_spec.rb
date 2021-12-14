require "rails_helper"

describe UsersController, type: :controller do
  render_views

  it "creates user" do
    post :create, params: { username: "Olaf" }
    post :create, params: { username: "Olaf" }
    post :create, params: { username: "Wojtek" }

    user = User.first
    expect(user.username).to eq "Olaf"
    user = User.last
    expect(user.username).to eq "Wojtek"
    expect(User.count).to eq 2
  end

  it "does not create a user without the username" do
    post :create, params: { username: nil }

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

    delete :destroy, params: { user_id: user.id }

    expect(User.count).to eq 0
  end
end