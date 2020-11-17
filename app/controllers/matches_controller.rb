class MatchesController < ApplicationController

  def match_create 
    match = Match.new
    match.team_1_name = params["team_1_name"]
    match.team_2_name = params["team_2_name"]
    match.match_result = params["match_result"]
    match.save
            
    redirect_to action: "index", controller: "users"
  end
        
  def match_destroy
    match = Match.find params["match_id"]
    
    match.players.destroy_all
    
    match.destroy!
        
    redirect_to action: "index", controller: "users"
  end

  def show
    @match = Match.find params["match_id"]
    @players = @match.players
    #@players = @match.players
    @other_users = User.all.to_a - @players.map { |player| player.user }
 
  end

  def add_goal_scored
    match = Match.find params["match_id"]
    player = Player.find params["player_id"]
    player.goals_scored = player.goals_scored + 1
    player.save 

    redirect_to action: "show", match_id: match.id
  end
 
end