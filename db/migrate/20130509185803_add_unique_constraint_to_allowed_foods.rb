class AddUniqueConstraintToAllowedFoods < ActiveRecord::Migration
  def change
    add_index :allowed_foods, [:food_id, :diet_id], :unique => true
  end
end
