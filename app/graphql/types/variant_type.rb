module Types
  class VariantType < BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :product, ProductType, null: false
    field :description, String, null: false
    field :price, Float, null: false
    field :size, String, null: false
    field :picture, String, null: false
    field :items, [ItemType], null: false
  end
end
