class RemoveColumnToLocation < ActiveRecord::Migration[6.0]
  def change
    remove_column :locations, :type, :integer
  end
end
