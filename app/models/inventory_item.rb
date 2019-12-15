class InventoryItem < ApplicationRecord
  belongs_to :item
  belongs_to :location
  belongs_to :inventory_item_state
  belongs_to :inventory_item_condition

validates :item, presence: true, length: { minimum: 3 }
validates :location, presence: true, length: { minimum: 3 }
validates :inventory_item_state, presence: true, length: { minimum: 3 }
validates :inventory_item_condition, presence: true, length: { minimum: 3 }

end
