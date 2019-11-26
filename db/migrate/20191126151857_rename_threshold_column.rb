class RenameThresholdColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :item_quantity_warning_thresholds, :qunatity, :quantity
  end
end
