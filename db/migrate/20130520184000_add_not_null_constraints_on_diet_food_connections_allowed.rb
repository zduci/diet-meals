class AddNotNullConstraintsOnDietFoodConnectionsAllowed < ActiveRecord::Migration
  def change
    change_column :diet_food_connections, :allowed, :boolean, :null => false
  end
end
