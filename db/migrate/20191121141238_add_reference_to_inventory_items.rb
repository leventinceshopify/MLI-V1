class AddReferenceToInventoryItems < ActiveRecord::Migration[6.0]
  def change

    add_reference :inventory_items, :nventory_item_condition
  end
end
