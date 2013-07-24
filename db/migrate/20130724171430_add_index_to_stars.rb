class AddIndexToStars < ActiveRecord::Migration
  def change
    add_index :stars, [:meal_diet_classification_id, :user_id]
  end
end
