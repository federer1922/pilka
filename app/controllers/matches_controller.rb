class MatchesController < ApplicationController

  def create 
    alert = MatchCreateService.call(match_params["home_team_name"], match_params["away_team_name"], match_params["home_score"], match_params["away_score"])
    if alert.present?
      flash[:alert] = alert
      redirect_to action: "index", controller: "users"
    else
      redirect_to action: "index", controller: "users"
    end
  end
        
  def destroy
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

  def match_params
    params.require(:match).permit("home_team_name", "away_team_name", "home_score", "away_score")
  end
end