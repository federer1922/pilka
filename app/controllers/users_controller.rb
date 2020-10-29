class UsersController < ApplicationController
  def create 
    user = User.new
    user.username = params["username"]
    user.save
    
    redirect_to action: "new"
  end
  
  def new
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
  end

  def add_goal
    user = User.find params["user_id"]
    user.goals_count = user.goals_count + 1
    user.save 

    redirect_to action: "new"
  end

  def subtract_goal
    user = User.find params["user_id"]
    user.goals_count = user.goals_count - 1
    if user.save
      #proceed
    else
      flash[:alert] = user.errors.full_messages.first 
    end

    redirect_to action: "new"
  end
  
end