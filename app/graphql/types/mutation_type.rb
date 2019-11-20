module Types
  class MutationType < Types::BaseObject
    field :create_item, mutation: Mutations::CreateItem
    field :create_variant, mutation: Mutations::CreateVariant
    field :create_product, mutation: Mutations::CreateProduct
    field :bind_item_to_variant, mutation: Mutations::BindItemToVariant
    field :create_inventory_item_state, mutation: Mutations::CreateInventoryItemState
    field :create_inventory_item, mutation: Mutations::CreateInventoryItem
    field :create_location, mutation: Mutations::CreateLocation
    field :create_location_type, mutation: Mutations::CreateLocationType
  end
end
