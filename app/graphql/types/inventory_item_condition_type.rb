module Types
  class InventoryItemConditionType < BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :inventory_items, [InventoryItemType], null: true
  end
end
