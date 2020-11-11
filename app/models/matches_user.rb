class MatchesUser < ApplicationRecord

  belongs_to :user 
  belongs_to :match 
    
def username
  user.username
end


end
  