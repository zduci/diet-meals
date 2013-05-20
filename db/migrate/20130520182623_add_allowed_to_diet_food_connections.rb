class AddAllowedToDietFoodConnections < ActiveRecord::Migration
  def change
    add_column :diet_food_connections, :allowed, :boolean
  end
end
