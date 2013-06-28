class RenameDietIdToMealDietClassificationId < ActiveRecord::Migration
  def change
    rename_column :stars, :diet_id, :meal_diet_classification_id
  end
end
