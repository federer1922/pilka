class User < ApplicationRecord

  validate :validate_goals_count
  # def goals_count
  #  @goals_count
  # end
  
  # def goals_count=(value)
  #  @goals_count = value
  # end  

  def minutes_played
    967
  end
  
  def validate_goals_count
    if goals_count < 0
      errors.add(:goals_count, 'cant be less than 0')
    end
  end
end
