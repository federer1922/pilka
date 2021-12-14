class PlayersController < ApplicationController
  def create
    if params["user_id"].nil?
      match = Match.find params["match_id"]

      flash[:alert] = "Player must be chosen"
      redirect_to action: "show", controller: "matches", match_id: match.id 
    else
      user = User.find params["user_id"]
      match = Match.find params["match_id"]
      squad = Squad.find params["squad_id"]
      player = Player.where(squad: squad, user: user).first 
      if player.nil?
        player = Player.new
        player.user = user 
        player.squad = squad
        player.goals_scored = 0
        user.match_count = user.match_count + 1
        user.save!
        player.save!
  
        redirect_to action: "show", controller: "matches", match_id: match.id
      else
        flash[:alert] = "Player already added"
        redirect_to action: "show", controller: "matches", match_id: match.id  
      end
    end
  end

  def destroy
    player = Player.find params["player_id"]
    match = Match.find params["match_id"]
    squad = Squad.find params["squad_id"]

    user = player.user
    user.match_count = user.match_count - 1
    user.goals_count = user.goals_count - player.goals_scored
    user.save!
    player.destroy!
    
    redirect_to action: "show", controller: "matches", match_id: match.id
  end

  def add_goal_scored  
    match = Match.find params["match_id"]
    player = Player.find params["player_id"]
    player.goals_scored = player.goals_scored + 1
    user = player.user
    user.goals_count = user.goals_count + 1
    user.save
    player.save

    redirect_to action: "show", controller: "matches", match_id: match.id
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
    redirect_to action: "show", controller: "matches", match_id: match.id
  end
end