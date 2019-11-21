class AddColumnToInventoryItemStates < ActiveRecord::Migration[6.0]
  def change
    add_column :inventory_item_states, :condition, :string
  end
end
