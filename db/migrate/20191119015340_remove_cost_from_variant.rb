class RemoveCostFromVariant < ActiveRecord::Migration[6.0]
  def change
    remove_column :variants, :cost, :float
  end
end
