class Change < ActiveRecord::Migration[6.0]
  def change
    rename_table :items_and_variants, :items_variants
  end
end
