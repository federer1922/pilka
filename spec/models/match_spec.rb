require "rails_helper"

describe Match, type: :model do
  describe 'associations' do
    it { should belong_to(:home_squad) }
    it { should belong_to(:away_squad) }
  end

  describe 'validations' do
    it { should validate_presence_of(:match_result) }
  end
end