class RenameRestrictiveToExclusive < ActiveRecord::Migration
  def change
    rename_column :diets, :restrictive, :exclusive
  end
end
