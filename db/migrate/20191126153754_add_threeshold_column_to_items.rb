class AddThreesholdColumnToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :quantity_threshold, :integer
  end
end
