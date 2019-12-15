module Mutations
  class CreateInventoryItem < BaseMutation
    # arguments passed to the `resolved` method
    argument :location_id, ID, required: true
    argument :item_id, ID, required: true
    argument :inventory_item_state_id, ID, required: true
    argument :inventory_item_condition_id, ID, required: true
    argument :quantity, Integer, required: false
    argument :quantity_warning_threshold, Integer, required: false

    type Types::InventoryItemType

    def resolve(location_id: nil, item_id: nil, inventory_item_state_id: nil,
      inventory_item_condition_id: nil, quantity: nil, quantity_warning_threshold: nil)
      ii = InventoryItem.find_by(location_id: location_id, item_id: item_id, inventory_item_state_id: inventory_item_state_id, inventory_item_condition_id: inventory_item_condition_id)
      InventoryItem.create!(
        location: Location.find(location_id),
        item: Item.find(item_id),
        inventory_item_state: InventoryItemState.find(inventory_item_state_id),
        inventory_item_condition: InventoryItemCondition.find(inventory_item_condition_id),
        quantity: quantity,
        quantity_warning_threshold: quantity_warning_threshold
      ) if ii.nil?
    end
  end
end
