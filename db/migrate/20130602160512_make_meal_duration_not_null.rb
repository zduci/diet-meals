class MakeMealDurationNotNull < ActiveRecord::Migration
  def change
    change_column :meals, :duration, :integer, :null => false
  end
end
