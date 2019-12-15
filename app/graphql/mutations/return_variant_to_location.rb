# frozen_string_literal: true

module Mutations
  class ReturnVariantToLocation < BaseMutation
    # arguments passed to the `resolved` method
    argument :variant_id, ID, required: true
    argument :location_id, ID, required: true
    argument :inventory_item_condition_name, String, required: true
    # return type from the mutation
    field :inventory_items, [Types::InventoryItemType], null: false
    field :errors, [String], null: true

    def resolve(variant_id:, location_id:, inventory_item_condition_name:)

      returned_inventory_items = Array.new(0)
      returned_errors = Array.new(0)
      allow_destroy_inital_state = true
      variant = Variant.find(variant_id)

      all_items_exist_at_location = check_availability_of_all_items(variant, location_id, "Not_Sellable", ["Shipped"])

      ActiveRecord::Base.transaction do
        all_items_exist_at_location && variant.items.each do |item|

          inventory_item_params = {item_id: item.id, location_id: location_id, inventory_item_condition_id: InventoryItemCondition.find_by(name:  "Not_Sellable" ).id, count: 1 }

          inventory_item_in_inital_state = get_item_in_this_state(inventory_item_params, "Shipped")
          initial_state_result = update_initial_state(inventory_item_in_inital_state, inventory_item_params[:count], allow_destroy_inital_state)
          
          returned_inventory_items.push(initial_state_result[:inventory_item]) if !initial_state_result[:inventory_item].nil?
          returned_errors.push(initial_state_result[:errors])
          inventory_item_params[:count] = initial_state_result[:dropped_count]

          #-----------BORDER BETWEEN INITIAL AND FINAL STATE-------------

          inventory_item_params[:inventory_item_condition_id] =   InventoryItemCondition.find_by(name:  inventory_item_condition_name ).id
          inventory_item_in_final_state = get_item_in_this_state(inventory_item_params, "Incoming")
          final_state_result = update_final_state(inventory_item_in_final_state, inventory_item_params, "Incoming")

          returned_inventory_items.push(final_state_result[:inventory_item]) if !final_state_result.nil?
          returned_errors.push(final_state_result[:errors]) if !final_state_result.nil?
        end
      end
      {errors: returned_errors}  if returned_errors.length >0
      {inventory_items: returned_inventory_items}
    end
  end
end
