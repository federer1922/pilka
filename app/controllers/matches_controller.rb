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
    MatchDestroyService.call(params["match_id"])
        
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