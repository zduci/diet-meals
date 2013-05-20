class RenameForbiddenFoodConnectionToDietFoodConnection < ActiveRecord::Migration
  def change
    rename_table :forbidden_food_connections, :diet_food_connections
  end
end
