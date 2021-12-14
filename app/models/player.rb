class Player < ApplicationRecord

  belongs_to :user 
  belongs_to :squad
    
  def username
    user.username
  end

  validates :goals_scored, presence: true
  validate :validate_goals_scored
    def validate_goals_scored
      if goals_scored && goals_scored < 0 
        errors.add(:goals_scored, 'can not be less than 0')
      end
    end
end
  