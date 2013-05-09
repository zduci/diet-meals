class AddUniqueConstraintToForbiddenFoods < ActiveRecord::Migration
  def change
    add_index :forbidden_foods, [:food_id, :diet_id], :unique => true
  end
end
