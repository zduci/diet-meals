class AddRestrictiveColumnToDiet < ActiveRecord::Migration
  def change
    add_column :diets, :restrictive, :boolean, :null => false
  end
end
