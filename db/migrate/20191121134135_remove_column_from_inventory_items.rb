class RemoveColumnFromInventoryItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :inventory_items, :is_sellable, :boolean
  end
end
