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
end