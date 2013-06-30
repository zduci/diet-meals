class RenameStarsToStarsCount < ActiveRecord::Migration
  def change
    rename_column :meal_diet_classifications, :stars, :stars_count
  end
end
