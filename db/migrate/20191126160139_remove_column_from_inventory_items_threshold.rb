class RemoveColumnFromInventoryItemsThreshold < ActiveRecord::Migration[6.0]
  def change
    remove_column :inventory_items, :quantity_warning_threshold, :integer
    remove_column :inventory_items, :item_quantity_warning_threshold_id, :integer
  end
end
