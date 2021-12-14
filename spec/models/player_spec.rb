require "rails_helper"

describe Player, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:squad) }
  end

  describe 'validations' do
    it { should validate_presence_of(:goals_scored) }
    it 'validate goals scored >= 0' do
      player = Player.new
      player.goals_scored = -1
      
      expect(player).to_not be_valid
      expect(player.errors[:goals_scored]).to eq ["can not be less than 0"]
    end
  end
end