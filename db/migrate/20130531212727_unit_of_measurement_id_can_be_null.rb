class UnitOfMeasurementIdCanBeNull < ActiveRecord::Migration
  def change
    change_column :ingredients, :unit_of_measurement_id, :integer, :null => true
  end
end
