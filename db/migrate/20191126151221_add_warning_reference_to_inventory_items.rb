class AddWarningReferenceToInventoryItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :inventory_items, :item_quantity_warning_threshold, foreign_key: true
  end
end
