class InventoryItemCondition < ApplicationRecord
  has_many :inventory_items , dependent: :destroy

  validates :name, presence: true, length: { minimum: 3 }, uniqueness: { case_sensitive: true }
end
