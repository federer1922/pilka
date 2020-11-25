namespace :data do
  
  task :fix => :environment do |task, args|
    Player.where(goals_scored: nil).update_all(goals_scored: 0)
    Match.all.each do |match|
    Player.where(team_name: nil).update_all(team_name: [match.team_1_name, match.team_2_name].sample)

    User.all.each do |user|
      players = user.players
      goals_count = players.map { |player| player.goals_scored }.reduce(:+) || 0
      user.goals_count = goals_count
      user.save!

      match_count = players.count
      user.match_count = match_count
      user.save!
    end
  end
  end
end