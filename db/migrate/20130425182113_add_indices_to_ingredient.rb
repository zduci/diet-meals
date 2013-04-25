class AddIndicesToIngredient < ActiveRecord::Migration
  def change
    add_index :ingredients, :food_id
    add_index :ingredients, :unit_of_measurement_id
  end
end
