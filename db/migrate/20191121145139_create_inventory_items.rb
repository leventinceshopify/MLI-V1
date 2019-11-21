class CreateInventoryItems < ActiveRecord::Migration[6.0]
  def change
    create_table :inventory_items do |t|
      t.references :item, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true
      t.references :inventory_item_state, null: false, foreign_key: true
      t.references :inventory_item_condition, null: false, foreign_key: true
      t.integer :quantity
      t.integer :quantity_warning_threshold

      t.timestamps
    end
  end
end
