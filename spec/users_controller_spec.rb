require "rails_helper"

describe UsersController, type: :controller do
  render_views

  it "creates user" do
    get :create, params: { username: "Olaf" }
   
    user = User.first
    expect(user.username). to eq "Olaf"
    expect(User.count).to eq 1
  end

  it "does not create a user without the username" do
    get :create, params: { username: "" }

    expect(flash[:alert]).to be_present
    expect(User.count).to eq 0
  end

  it "deletes user" do
    match = Match.new(team_1_name: "Lech", team_2_name: "Warta", match_result: "0:0")
    match.save!

    user = User.new(username: "Olaf", goals_count: 0, match_count: 0)
    user.save!

    player = Player.new
    player.user = user
    player.match = match
    player.goals_scored = 0
    player.save!

    get :destroy, params: { user_id: user.id }

    expect(User.count).to eq 0
  end

  it "adds player to team" do
    match = Match.new(team_1_name: "Lech", team_2_name: "Warta", match_result: "0:0")
    match.save!

    user = User.new(username: "Olaf", goals_count: 0, match_count: 0)
    user.save!

    player = Player.new
    player.user = user
    player.match = match
    player.goals_scored = 0
    user.match_count = user.match_count + 1
    user.save!
    player.save!

    get :add_player_to_team, params: { match_id: match.id, user_id: user.id }

    expect(Player.count).to eq 1
    expect(user.reload.match_count).to eq 1
  end

  it "destroys player" do
    user = User.new(username: "Olaf", goals_count: 10, match_count: 10)
    user.save!
    match = Match.new(team_1_name: "Lech", team_2_name: "Warta", match_result: "0:0")
    match.save!
    
    player = Player.new
    player.user = user
    player.match = match
    player.goals_scored = 4
    player.save!

    get :destroy_player, params: { match_id: match.id, player_id: player.id }
    
    expect(Player.count).to eq 0
    expect(user.reload.goals_count).to eq 6
    expect(user.reload.match_count).to eq 9
  end

end