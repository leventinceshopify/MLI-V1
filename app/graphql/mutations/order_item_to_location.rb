
module Mutations
  class OrderItemToLocation < BaseMutation
    # arguments passed to the `resolved` method
    argument :item_id, ID, required: true
    argument :location_id, ID, required: true
    argument :count, Integer, required: true
    # return type from the mutation
    field :inventory_items, [Types::InventoryItemType], null: false
    field :errors, [String], null: true

    def resolve(item_id:, location_id:, count:)
      returned_inventory_items = Array.new(0)
      returned_errors = Array.new(0)
      inventory_item_params = {item_id: item_id, location_id: location_id, inventory_item_condition_id: InventoryItemCondition.find_by(name:  "Not_Sellable" ).id, count: count }

        #-----------BORDER BETWEEN INITIAL AND FINAL STATE THERE IS NO INITAL STATE-------------
      inventory_item_in_final_state = get_item_in_this_state(inventory_item_params, "Ordered")
      final_state_result = update_final_state(inventory_item_in_final_state, inventory_item_params, "Ordered")

      returned_inventory_items.push(final_state_result[:inventory_item]) if !final_state_result.nil?
      returned_errors.push(final_state_result[:errors]) if !final_state_result.nil?

      {errors: returned_errors}  if returned_errors.length >0
      {inventory_items: returned_inventory_items}
    end
  end
end
