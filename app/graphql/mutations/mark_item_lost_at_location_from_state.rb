# frozen_string_literal: true

module Mutations
  class MarkItemLostAtLocationFromState < BaseMutation
    # arguments passed to the `resolved` method
    argument :item_id, ID, required: true
    argument :location_id, ID, required: true
    argument :inventory_item_state_name, String, required: true
    argument :inventory_item_condition_name, String, required: true
    # return type from the mutation
    field :inventory_items, [Types::InventoryItemType], null: false
    field :errors, [String], null: true

    def resolve(item_id:, location_id:, inventory_item_state_name:, inventory_item_condition_name:)

      returned_inventory_items = Array.new(0)
      returned_errors = Array.new(0)
      inventory_item_params = {item_id: item_id, location_id: location_id, inventory_item_condition_id: InventoryItemCondition.find_by(name:  inventory_item_condition_name).id, count: 1 }
      allow_destroy_inital_state = false

      inventory_item_in_inital_state = get_item_in_this_state(inventory_item_params, inventory_item_state_name)
      initial_state_result = update_initial_state(inventory_item_in_inital_state, inventory_item_params[:count], allow_destroy_inital_state)
      if inventory_item_state_name== "Available" || inventory_item_state_name== "Critical_Level"
        set_sellable_item_state(initial_state_result)
      end

      returned_inventory_items.push(initial_state_result[:inventory_item]) if !initial_state_result[:inventory_item].nil?
      returned_errors.push(initial_state_result[:errors])
      inventory_item_params[:count] = initial_state_result[:dropped_count]

      #-----------BORDER BETWEEN INITIAL AND FINAL STATE-------------

      inventory_item_params[:inventory_item_condition_id] =   InventoryItemCondition.find_by(name:  "Not_Sellable" ).id
      inventory_item_in_final_state = get_item_in_this_state(inventory_item_params, "Lost")
      final_state_result = update_final_state(inventory_item_in_final_state, inventory_item_params, "Lost")

      returned_inventory_items.push(final_state_result[:inventory_item]) if !final_state_result.nil?
      returned_errors.push(final_state_result[:errors]) if !final_state_result.nil?

      {errors: returned_errors}  if returned_errors.length >0
      {inventory_items: returned_inventory_items}
    end
  end
end
