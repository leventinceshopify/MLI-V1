# frozen_string_literal: true

module Mutations
  class AcceptItemsAtLocation < BaseMutation
    # arguments passed to the `resolved` method
    argument :item_id, ID, required: true
    argument :location_id, ID, required: true
    argument :inventory_item_condition_name, String, required: true
    argument :count, Integer, required: true
    field :inventory_items, [Types::InventoryItemType], null: false
    field :errors, [String], null: true

    def resolve(item_id:, location_id:, count:, inventory_item_condition_name:)

      returned_inventory_items = Array.new(0)
      returned_errors = Array.new(0)
      allow_destroy_inital_state = true

      inventory_item_params = {item_id: item_id, location_id: location_id, inventory_item_condition_id: InventoryItemCondition.find_by(name:  inventory_item_condition_name ).id, count: count }
      ActiveRecord::Base.transaction do
        inventory_item_in_inital_state = get_item_in_this_state(inventory_item_params, "Incoming")
        if inventory_item_in_inital_state.nil?
          inventory_item_params[:inventory_item_condition_id] = InventoryItemCondition.find_by(name:  "Normal" ).id
          inventory_item_in_inital_state = get_item_in_this_state(inventory_item_params, "Incoming")
        end
        initial_state_result = update_initial_state(inventory_item_in_inital_state, inventory_item_params[:count], allow_destroy_inital_state)
        returned_inventory_items.push(initial_state_result[:inventory_item]) if !initial_state_result[:inventory_item].nil?
        returned_errors.push(initial_state_result[:errors])
        inventory_item_params[:count] = initial_state_result[:dropped_count].nil? ? 0 : initial_state_result[:dropped_count]

        #-----------BORDER BETWEEN INITIAL AND FINAL STATE-------------
        inventory_item_params[:inventory_item_condition_id] = InventoryItemCondition.find_by(name:  inventory_item_condition_name ).id
        if inventory_item_params[:count] > 0
          inventory_item_in_final_state = get_item_from_sellable_state(inventory_item_params)
          final_state_result = update_final_state(inventory_item_in_final_state, inventory_item_params, "Critical_Level")
          set_sellable_item_state(final_state_result)
        end
        returned_inventory_items.push(final_state_result[:inventory_item]) if !final_state_result.nil?
        returned_errors.push(final_state_result[:errors]) if !final_state_result.nil?
      end
      {errors: returned_errors}  if returned_errors.length > 0
      {inventory_items: returned_inventory_items}
    end
  end
end
