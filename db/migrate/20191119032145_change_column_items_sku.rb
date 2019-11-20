class ChangeColumnItemsSku < ActiveRecord::Migration[6.0]
  def change
    rename_column :items, :SKU, :sku
  end
end
