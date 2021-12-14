module MatchDestroyService
  def self.call(id)
    match = Match.find id  
    match.home_squad.players.each do |player|
      user = player.user
      user.match_count = user.match_count - 1
      user.goals_count = user.goals_count - player.goals_scored
      user.save!
    end
    match.away_squad.players.each do |player|
      user = player.user
      user.match_count = user.match_count - 1
      user.goals_count = user.goals_count - player.goals_scored
      user.save!
    end 
    match.home_squad.players.destroy_all
    match.away_squad.players.destroy_all
    match.home_squad.destroy!
    match.away_squad.destroy!
    match.destroy!
  end
end