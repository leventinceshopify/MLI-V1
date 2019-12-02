# frozen_string_literal: true

module Mutations
  class RemoveOrderOfItem < BaseMutation
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
      inventory_item_params = {item_id: item_id, location_id: location_id, inventory_item_condition_id: InventoryItemCondition.find_by(name:  "Normal" ).id, count: count }
      allow_destroy_inital_state = true

      inventory_item_in_inital_state = get_item_in_this_state(inventory_item_params, "Ordered")
      initial_state_result = update_initial_state(inventory_item_in_inital_state, inventory_item_params[:count], allow_destroy_inital_state)

      returned_inventory_items.push(initial_state_result[:inventory_item]) if !initial_state_result[:inventory_item].nil?
      returned_errors.push(initial_state_result[:errors])

      #-----------BORDER BETWEEN INITIAL AND FINAL STATE : THERE IS NO FINAL STATE-------------

      {errors: returned_errors}  if returned_errors.length >0
      {inventory_items: returned_inventory_items}

    end
  end
end
