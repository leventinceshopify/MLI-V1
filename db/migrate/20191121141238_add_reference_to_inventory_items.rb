class AddReferenceToInventoryItems < ActiveRecord::Migration[6.0]
  def change

    add_reference :inventory_items, :inventory_item_condition
  end
end
