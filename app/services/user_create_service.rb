module UserCreateService
  def self.call(username)
    alert = nil
    user_already_in_database = User.where(username: username).first
    if user_already_in_database.nil?
      user = User.new
      user.username = username
      user.goals_count = 0
      user.match_count = 0
      if !user.save
        alert = user.errors.full_messages.first
      end
    else
      alert = "User already added" 
    end
    alert
  end
end