module Types
  class ProductType < BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: true
    field :picture, String, null: false
    field :variants, [VariantType], null: false
  end
end
