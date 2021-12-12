class MatchesController < ApplicationController

  def match_create 
    alert = MatchCreateService.call(match_params["home_team_name"], match_params["away_team_name"], match_params["home_score"], match_params["away_score"])
    if alert.present?
      flash[:alert] = alert
      redirect_to action: "index", controller: "users"
    else
      redirect_to action: "index", controller: "users"
    end
  end
        
  def match_destroy
    match = Match.find params["match_id"]

    match.home_squad.players.each do |player|
      user = player.user
      user.match_count = user.match_count - 1
      user.goals_count = user.goals_count - player.goals_scored
      user.save!
    end
    match.away_squad.players.each do |player|
      user = player.user
      user.match_count = user.match_count - 1
      user.goals_count = user.goals_count - player.goals_scored
      user.save!
    end

    match.home_squad.players.destroy_all
    match.away_squad.players.destroy_all
    match.home_squad.destroy!
    match.away_squad.destroy!
    match.destroy!
        
    redirect_to action: "index", controller: "users"
  end

  def show
    @match = Match.find params["match_id"]
    @home_squad = @match.home_squad 
    @away_squad = @match.away_squad
    @home_players = @home_squad.players.order(:created_at).to_a
    @away_players = @away_squad.players.order(:created_at).to_a
    @other_users = User.all.to_a - @home_players.map { |player| player.user } - @away_players.map { |player| player.user }
  end

  def add_goal_scored  
    match = Match.find params["match_id"]
    player = Player.find params["player_id"]
    player.goals_scored = player.goals_scored + 1
    user = player.user
    user.goals_count = user.goals_count + 1
    user.save
    player.save

    redirect_to action: "show", match_id: match.id
  end

  def subtract_goal_scored  
    match = Match.find params["match_id"]
    player = Player.find params["player_id"]
    player.goals_scored = player.goals_scored - 1
    if player.save
    user = player.user
    user.goals_count = user.goals_count - 1
    user.save
    else
      flash[:alert] = player.errors.full_messages.first 
    end
    redirect_to action: "show", match_id: match.id
  end 

  def match_params
    params.require(:match).permit("home_team_name", "away_team_name", "home_score", "away_score")
  end
end