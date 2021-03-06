module Types
  class MutationType < Types::BaseObject
    field :create_item, mutation: Mutations::CreateItem
    field :create_variant, mutation: Mutations::CreateVariant
    field :create_product, mutation: Mutations::CreateProduct
    field :update_product, mutation: Mutations::UpdateProduct
    field :bind_item_to_variant, mutation: Mutations::BindItemToVariant
    field :create_inventory_item_state, mutation: Mutations::CreateInventoryItemState
    field :create_inventory_item_condition, mutation: Mutations::CreateInventoryItemCondition
    field :create_inventory_item, mutation: Mutations::CreateInventoryItem
    field :create_location, mutation: Mutations::CreateLocation
    field :create_location_type, mutation: Mutations::CreateLocationType
    field :sign_in, mutation: Mutations::SignInMutation
    field :sell_variant_from_location, mutation: Mutations::SellVariantFromLocation
    field :ship_variant, mutation: Mutations::ShipVariant
    field :return_variant_to_location, mutation: Mutations::ReturnVariantToLocation
    field :order_item_to_location, mutation: Mutations::OrderItemToLocation
    field :ship_item_to_location_from_supplier, mutation: Mutations::ShipItemToLocationFromSupplier
    field :accept_items_at_location, mutation: Mutations::AcceptItemsAtLocation
    field :mark_item_lost_at_location_from_state, mutation: Mutations::MarkItemLostAtLocationFromState
    field :transfer_item_from_location_to_location, mutation: Mutations::TransferItemFromLocationToLocation
    field :remove_order_of_item, mutation: Mutations::RemoveOrderOfItem
    field :cancel_sale_of_variant, mutation: Mutations::CancelSaleOfVariant
    field :delete_product, mutation: Mutations::DeleteProduct
    field :delete_variant, mutation: Mutations::DeleteVariant
    field :delete_item_variant, mutation: Mutations::DeleteItemVariant
    field :update_variant, mutation: Mutations::UpdateVariant
    field :update_item, mutation: Mutations::UpdateItem
    field :delete_item, mutation: Mutations::DeleteItem
    field :delete_inventory_item_condition, mutation: Mutations::DeleteInventoryItemCondition
    field :delete_inventory_item_state, mutation: Mutations::DeleteInventoryItemState

  end
end
