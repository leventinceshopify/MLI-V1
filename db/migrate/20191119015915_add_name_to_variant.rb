class AddNameToVariant < ActiveRecord::Migration[6.0]
  def change
    add_column :variants, :name, :string
  end
end
