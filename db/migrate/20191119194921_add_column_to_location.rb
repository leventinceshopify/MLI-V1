class AddColumnToLocation < ActiveRecord::Migration[6.0]
  def change
    add_reference(:locations, :location_type)
  end
end
