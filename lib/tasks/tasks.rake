namespace :data do
  
  task :fix => :environment do |task, args|
    #Player.where(goals_scored: nil).update_all(goals_scored: 0)

    User.all.each do |user|
      match_ids = []
      user.players.each do |player|
        begin
          match = Match.all.sample  
        end while match_ids.include?(match.id)
        match_ids << match.id
        
        squad = [match.home_squad, match.away_squad].sample
        



        player.squad = squad
        player.save!
      end
    end



   # Squad.all.each do |squad|
      #if !match.home_squad
       # home_squad = Squad.new
        #home_squad.team_name = match.team_1_name
        #home_squad.save!
        #match.home_squad = home_squad
      #end
    
     # if !match.away_squad
      #  away_squad = Squad.new
       # away_squad.team_name = match.team_2_name
        #away_squad.save!
        #match.away_squad = away_squad
      #en

      #match.save!
      #Player.all.each do |player| 
       # squad = Squad.all.sample
        #player.squad = squad
        #user = player.user
        #player = Player.where(squad: squad, user: user).first
        #until Player.new
        #player.save!
        #end
      #end

      #Player.where(squad_id: nil).each do |player|
       # player.squad_id = [match.home_squad_id, match.away_squad_id].sample
        #player.save!
      #end  
      #Player.where(squad_id: 9).update_all(squad_id: [match.home_squad_id, match.away_squad_id].sample)
      #Player.where(squad_id: nil).each do |player|
  
       # player.squad_id = [match.home_squad_id, match.away_squad_id].sample
        #player.save!
      #end

      #Player.where(squad_id: nil).each do |player|
       # player.squad_id = [match.home_squad_id, match.away_squad_id].sample
        #player.save!
      #end
      #Player.where(team_name: nil).update_all(team_name: [match.team_1_name, match.team_2_name].sample)

      #User.all.each do |user|
       # players = user.players
        #goals_count = players.map { |player| player.goals_scored }.reduce(:+) || 0
        #user.goals_count = goals_count
        #user.save!

        #match_count = players.count
        #user.match_count = match_count
        #user.save!
      #end
   # end
  end
end