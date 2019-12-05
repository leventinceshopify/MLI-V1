# frozen_string_literal: true

module Mutations
  class ShipItemToLocationFromSupplier < BaseMutation
    # arguments passed to the `resolved` method
    argument :item_id, ID, required: true
    argument :location_id, ID, required: true
    argument :count, Integer, required: true
    # return type from the mutation
    field :inventory_items, [Types::InventoryItemType], null: true
    field :errors, [String], null: true

    def resolve(item_id:, location_id:, count:)

      returned_inventory_items = Array.new(0)
      returned_errors = Array.new(0)
      allow_destroy_inital_state = true
ActiveRecord::Base.transaction do
      inventory_item_params = {item_id: item_id, location_id: location_id, inventory_item_condition_id: InventoryItemCondition.find_by(name:  "Not_Sellable" ).id, count: count }
      inventory_item_in_inital_state = get_item_in_this_state(inventory_item_params, "Ordered")
      initial_state_result = update_initial_state(inventory_item_in_inital_state, inventory_item_params[:count], allow_destroy_inital_state)

      returned_inventory_items.push(initial_state_result[:inventory_item]) if !initial_state_result[:inventory_item].nil?
      returned_errors.push(initial_state_result[:errors])
      inventory_item_params[:count] = initial_state_result[:dropped_count]

      #-----------BORDER BETWEEN INITIAL AND FINAL STATE-------------

      inventory_item_params[:inventory_item_condition_id] = InventoryItemCondition.find_by(name:  "Normal" ).id
      inventory_item_in_final_state = get_item_in_this_state(inventory_item_params, "Incoming")
      final_state_result = update_final_state(inventory_item_in_final_state, inventory_item_params, "Incoming")

      returned_inventory_items.push(final_state_result[:inventory_item]) if !final_state_result.nil?
      returned_errors.push(final_state_result[:errors]) if !final_state_result.nil?
end
      {errors: returned_errors}  if returned_errors.length >0
      {inventory_items: returned_inventory_items}

    end
  end
end
