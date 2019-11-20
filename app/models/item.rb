class Item < ApplicationRecord
  # has_and_belongs_to_many :variants
  has_many :item_variants
  has_many :variants, through: :item_variants
  has_many :inventory_items , dependent: :destroy
end
