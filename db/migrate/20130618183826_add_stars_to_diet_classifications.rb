class AddStarsToDietClassifications < ActiveRecord::Migration
  def change
    add_column :diet_classifications, :stars, :integer, :default => 0, :null => false
  end
end
