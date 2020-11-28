class Player < ApplicationRecord

  belongs_to :user 
  belongs_to :match 
  belongs_to :squad
    
  def username
    user.username
  end

validate :validate_goals_scored
  def validate_goals_scored
    if goals_scored < 0
      errors.add(:goals_scored, 'can not be less than 0')
    end
  end

end
  