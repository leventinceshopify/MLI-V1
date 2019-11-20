class CreateDropshippers < ActiveRecord::Migration[6.0]
  def change
    create_table :dropshippers do |t|
      t.string :distribution_zone
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
