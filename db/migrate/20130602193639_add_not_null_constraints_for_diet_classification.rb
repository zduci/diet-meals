class AddNotNullConstraintsForDietClassification < ActiveRecord::Migration
  def change
    change_column :diet_classifications, :meal_id, :integer, :null => false
    change_column :diet_classifications, :diet_id, :integer, :null => false
  end
end
