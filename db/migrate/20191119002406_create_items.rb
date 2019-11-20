class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.integer :SKU
      t.string :name
      t.text :description
      t.float :cost
      t.float :price
      t.string :size
      t.string :manufacturer
      t.string :type
      t.string :picture

      t.timestamps
    end
  end
end
