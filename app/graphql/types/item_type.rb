module Types
  class ItemType < BaseObject
    field :id, ID, null: false
    field :sku, Integer, null: false
    field :name, String, null: false
    field :description, String, null: false
    field :cost, Float, null: false
    field :size, String, null: true
    field :manufacturer, String, null: true
    field :picture, String, null: true
    field :variants, [VariantType], null: false
  end
end
