class CreateInventoryItemConditions < ActiveRecord::Migration[6.0]
  def change
    create_table :inventory_item_conditions do |t|
      t.string :name

      t.timestamps
    end
  end
end
