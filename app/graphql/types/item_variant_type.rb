module Types
  class ItemVariantType < BaseObject
    field :id, ID, null: false
    field :item, ItemType, null: false
    field :variant, VariantType, null: false
  end
end
