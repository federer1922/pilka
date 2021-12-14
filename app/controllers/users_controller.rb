class UsersController < ApplicationController
  def create
    alert = UserCreateService.call(params["username"])
    if alert.present?
      flash[:alert] = alert
      redirect_to action: "index"
    else
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