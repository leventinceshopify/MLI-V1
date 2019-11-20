module Mutations
  class CreateInventoryItem < BaseMutation
    # arguments passed to the `resolved` method
    argument :location_id, ID, required: true
    argument :item_id, ID, required: true
    argument :inventory_item_state_id, ID, required: false
    argument :quantity, Integer, required: false
    argument :is_sellable, Boolean, required: true
    argument :quantity_warning_threshold, Integer, required: false


    # return type from the mutation
    type Types::InventoryItemType

    def resolve(location_id: nil, item_id: nil, inventory_item_state_id: nil,
      quantity: nil, is_sellable: true, quantity_warning_threshold: nil)

      InventoryItem.create!(
        location: Location.find(location_id),
        item: Item.find(item_id),
        inventory_item_state: InventoryItemState.find(inventory_item_state_id),
        quantity: quantity,
        is_sellable: is_sellable,
        quantity_warning_threshold: quantity_warning_threshold
      )
    end
  end
end

#
# field :id, ID, null: false
# # field :item, ItemType, null: false
# # field :location, LocationType, null: false
# # field :inventory_item_state, InventoryItemStateType, null: false
# # field :quantity, Integer, null: false
# field :is_sellabe, Boolean, null: false
# field :quantity_warning_threshold, Integer, null: false
