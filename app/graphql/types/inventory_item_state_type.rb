module Types
  class InventoryItemStateType < BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: true
    field :inventory_items, [InventoryItemType], null: true
  end
end
