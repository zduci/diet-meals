class AddNotNullConstraintsToIngredients < ActiveRecord::Migration
  def change
    change_column :ingredients, :food_id, :integer, :null => false
    change_column :ingredients, :quantity, :integer, :null => false
    change_column :ingredients, :unit_of_measurement_id, :integer, :null => false
  end
end
