class ItemVariant < ApplicationRecord
  belongs_to :variant
  belongs_to :item
end
