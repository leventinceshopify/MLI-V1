class DropTableItemQuantityWarningThreshold < ActiveRecord::Migration[6.0]
  def change
    drop_table :item_quantity_warning_thresholds
  end
end
