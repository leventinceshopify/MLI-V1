class CreateInventoryItemStates < ActiveRecord::Migration[6.0]
  def change
    create_table :inventory_item_states do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
