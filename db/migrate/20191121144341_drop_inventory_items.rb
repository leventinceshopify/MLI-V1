class DropInventoryItems < ActiveRecord::Migration[6.0]
  def change
    drop_table :inventory_items
  end
end
