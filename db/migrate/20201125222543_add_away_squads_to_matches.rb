class AddAwaySquadsToMatches < ActiveRecord::Migration[6.0]
  def change
    add_reference :matches, :away_squad, index: true
  end
end
