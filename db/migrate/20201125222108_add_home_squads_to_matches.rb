class AddHomeSquadsToMatches < ActiveRecord::Migration[6.0]
  def change
    add_reference :matches, :home_squad, index: true
  end
end
