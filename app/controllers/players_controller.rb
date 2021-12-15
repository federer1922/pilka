class PlayersController < ApplicationController
  def create
    match = Match.find params["match_id"]
    alert = PlayerCreateService.call(params["user_id"], params["squad_id"])
    if alert.present?
      flash[:alert] = alert
      redirect_to action: "show", controller: "matches", match_id: match.id
    else
      redirect_to action: "show", controller: "matches", match_id: match.id
    end
  end

  def destroy
    match = Match.find params["match_id"]
    PlayerDestroyService.call(params["player_id"])

    redirect_to action: "show", controller: "matches", match_id: match.id
  end

  def add_goal_scored 
    match = Match.find params["match_id"]
    AddGoalService.call(params["player_id"])
    
    redirect_to action: "show", controller: "matches", match_id: match.id
  end

  def subtract_goal_scored  
    match = Match.find params["match_id"]
    alert = SubtractGoalService.call(params["player_id"])
    if alert.present?
      flash[:alert] = alert
      redirect_to action: "show", controller: "matches", match_id: match.id
    else
      redirect_to action: "show", controller: "matches", match_id: match.id
    end
  end
end