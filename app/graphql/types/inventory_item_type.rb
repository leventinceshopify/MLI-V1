module Types
  class InventoryItemType < BaseObject
    field :id, ID, null: false
    field :item, ItemType, null: false
    field :location, LocationType, null: false
    field :inventory_item_state, InventoryItemStateType, null: false
    field :inventory_item_condition, InventoryItemConditionType, null: false
    field :quantity, Integer, null: false
    field :quantity_warning_threshold, Integer, null: false
  end
end
