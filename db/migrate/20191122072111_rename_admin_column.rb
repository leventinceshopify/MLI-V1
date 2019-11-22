class RenameAdminColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :admins, :name, :username
  end
end
