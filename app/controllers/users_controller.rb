class UsersController < ApplicationController
  def create 

    user_already_in_database = User.where(username: params["username"]).first
    
    if user_already_in_database.nil?
      user = User.new
      user.username = params["username"]
      user.goals_count = 0
      user.match_count = 0
      if user.save
        redirect_to action: "index" 
      else
        flash[:alert] = user.errors.full_messages.first
        redirect_to action: "index"
      end
    else
      flash[:alert] = "User already added" 
      redirect_to action: "index"
    end
  end

  def destroy

    user = User.find params["user_id"]
    user.players.destroy_all
    user.destroy!
    redirect_to action: "index"
  end

  def index
    
    @users = User.all.order(:created_at)
    @matches = Match.all.order(:created_at)
    @players = Player.all.order(:created_at)
    @squads = Squad.all.order(:created_at)
  end
  
  def add_player_to_squad
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

  def destroy_player
    
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
end