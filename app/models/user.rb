class User < ApplicationRecord

  has_many :players 
  has_many :matches, through: :players

  validates :username, presence: true

  validate :validate_goals_count
  # def goals_count
  #  @goals_count
  # end
  
  # def goals_count=(value)
  #  @goals_count = value
  # end  
  
  def validate_goals_count
    if goals_count < 0
      errors.add(:goals_count, 'cant be less than 0')
    end
  end
 
  validate :validate_match_count
  def validate_match_count
    if match_count < 0
      errors.add(:match_count, 'cant be less than 0')
    end
  end


end


