class AddIndexToFoodName < ActiveRecord::Migration
  def change
    add_index :foods, :name
  end
end
