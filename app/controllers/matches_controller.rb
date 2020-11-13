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
    
    match.matches_users.destroy_all
    
    match.destroy!
        
    redirect_to action: "index", controller: "users"
  end

  def show
    @match = Match.find params["match_id"]
    @players = @match.matches_users
    #@players = @match.matches_users
    @other_users = User.all.to_a - @players.map { |player| player.user }
 

  end
 

end