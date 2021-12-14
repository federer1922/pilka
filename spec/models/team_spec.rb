require "rails_helper"

describe Team, type: :model do
  describe 'associations' do
    it { should have_many(:squads) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end