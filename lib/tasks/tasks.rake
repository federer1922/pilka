namespace :abc do
  
  task :fix_data => :environment do |task, args|
    Player.where(goals_scored: nil).update_all(goals_scored: 0)

    User.all.each do |user|
      players = user.players
      goals_count = players.map { |player| player.goals_scored }.reduce(:+)
      user.goals_count = goals_count
      user.save!
   
      players = user.players
      match_count = players.count
      user.match_count = match_count
      user.save!
    end
  end
end