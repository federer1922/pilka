class UsersController < ApplicationController
  def create 
    user = User.new
    user.username = params["username"]
    user.goals_count = 0
    user.match_count = 0
    user.save
    
    redirect_to action: "index"
  end

  def destroy
    user = User.find params["user_id"]
    user.destroy!

    redirect_to action: "index"
  end

  def index
    #user = User.new
    #user.username = "Arek"z
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
    @match = Match.all.order(:created_at)
   
  end

  def show_match

    @match= Match.find params["match_id"]

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

  def match_create 
    match = Match.new
    match.team_1_name = params["team_1_name"]
    match.team_2_name = params["team_2_name"]
    match.match_result = params["match_result"]
    match.save
        
    redirect_to action: "index"
  end
    
  def match_destroy
    match = Match.find params["match_id"]
    match.destroy!
    
    redirect_to action: "index"
  end
  
  def add_player_to_match
    match = Match.find params["match_id"]
    user = User.find params["user_id"]
  
    matches_user = MatchesUser.new
    matches_user.match = match
    matches_user.user = user
    matches_user.save

    redirect_to action: "index"
  end
 
end