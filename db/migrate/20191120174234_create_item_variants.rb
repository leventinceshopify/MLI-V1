class CreateItemVariants < ActiveRecord::Migration[6.0]
  def change
    create_table :item_variants do |t|
      t.references :variant, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
