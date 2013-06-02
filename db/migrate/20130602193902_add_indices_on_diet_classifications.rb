class AddIndicesOnDietClassifications < ActiveRecord::Migration
  def change
    add_index :diet_classifications, :meal_id
    add_index :diet_classifications, :diet_id
  end
end
