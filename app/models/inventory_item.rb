class InventoryItem < ApplicationRecord
  belongs_to :item
  belongs_to :location
  belongs_to :inventory_item_state
  belongs_to :inventory_item_condition
end
