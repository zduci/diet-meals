class AddIndexToAllowedFoodConnectionDietId < ActiveRecord::Migration
  def change
    add_index :allowed_food_connections, :diet_id
  end
end
