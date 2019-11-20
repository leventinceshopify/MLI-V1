class CreateVariants < ActiveRecord::Migration[6.0]
  def change
    create_table :variants do |t|
      t.text :description
      t.float :cost
      t.float :price
      t.string :size
      t.string :picture
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
