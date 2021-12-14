require "rails_helper"

describe Squad, type: :model do
  describe 'associations' do
    it { should have_many(:players) }
    it { should have_one(:home_match) }
    it { should have_one(:away_match) }
    it { should have_many(:users).through(:players) }
    it { should belong_to(:team) }
  end

  describe 'validations' do
    it { should validate_presence_of(:team_name) }
  end
end