class InventoryItemCondition < ApplicationRecord
  has_many :inventory_items , dependent: :destroy
end
