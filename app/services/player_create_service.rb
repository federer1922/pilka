module PlayerCreateService
  def self.call(user_id, match_id, squad_id)
    alert = nil
    if user_id.nil?
      match = Match.find match_id
      alert = "Player must be chosen"
    else
      user = User.find user_id
      match = Match.find match_id
      squad = Squad.find squad_id
      player = Player.where(squad: squad, user: user).first 
      if player.nil?
        player = Player.new
        player.user = user 
        player.squad = squad
        player.goals_scored = 0
        user.match_count = user.match_count + 1
        user.save!
        player.save!
      else
        alert = "Player already added" 
      end
    end
    alert
  end
end