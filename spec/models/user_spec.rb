require "rails_helper"

describe User, type: :model do
  describe 'associations' do
    it { should have_many(:players) }
    it { should have_many(:squads).through(:players) }
  end

  describe 'validations' do
    it { should validate_presence_of(:username) }
  end
end