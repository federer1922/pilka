class UsersController < ApplicationController
  def create 
    user_already_in_database = User.where(username: params["username"]).first
    
    if user_already_in_database.nil?
      user = User.new
      user.username = params["username"]
      user.match_count = 0
      if user.save
        redirect_to action: "index" 
      else
        flash[:alert] = user.errors.full_messages.first
        redirect_to action: "index"
      end
    else
      flash[:alert] = "Player already added" 
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
    #user = User.new
    #user.username = "Arek"
    #user2 = User.new
    #user2.username = "Pawel"
    #user3 = User.new
    #user3.username = "Eryk"
    #user4 = User.new
    #user4.username = "Grzegorz"
    #user5 = User.new
    #user5.username = "Wojtek"
    #user6 = User.new
    #user6.username = "Kasia"

    #@users = [user, user2, user3, user4, user5, user6, user6]
    
    @users = User.all.order(:created_at)
    @matches = Match.all.order(:created_at)
    @players = Player.all.order(:created_at)
  end

  def add_goal
    user = User.find params["user_id"]
   
    user.goals_count = user.goals_count + 1
    user.save 
    redirect_to action: "index"

  end

  def subtract_goal
    user = User.find params["user_id"]
    user.goals_count = user.goals_count - 1
    if user.save
      #proceed
    else
      flash[:alert] = user.errors.full_messages.first 
    end

    redirect_to action: "index"
  end
  
  def add_match
    user = User.find params["user_id"]
    user.match_count = user.match_count + 1
    user.save 
    
    redirect_to action: "index"
  end  

  def subtract_match
    user = User.find params["user_id"]
    user.match_count = user.match_count - 1
    if user.save
      #proceed
    else
      flash[:alert] = user.errors.full_messages.first

    end
      redirect_to action: "index"

  end
  
  
  def add_player_to_match
    match = Match.find params["match_id"]
    user = User.find params["user_id"]

    player = Player.where(match: match, user: user).first
    if player.nil?
      player = Player.new
      player.match = match
      player.user = user
      player.goals_scored = 0
      player.save

      redirect_to action: "show", controller: "matches", match_id: match.id
    else
      flash[:alert] = "Player already added"
      redirect_to action: "show", controller: "matches", match_id: match.id
      
    end
  end

  def destroy_player
    match = Match.find params["match_id"]
    player = Player.find params["player_id"]
    
    player.destroy!
    
    
    
    redirect_to action: "show", controller: "matches", match_id: match.id
  
  end

end