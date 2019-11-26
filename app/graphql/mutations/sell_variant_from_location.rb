# frozen_string_literal: true

module Mutations
  class SellVariantFromLocation < BaseMutation
    # arguments passed to the `resolved` method
    argument :variant_id, ID, required: true
    argument :location_id, ID, required: true
    argument :inventory_item_condition_name, String, required: true
    # return type from the mutation
    field :inventory_items, [Types::InventoryItemType], null: false
    field :errors, [String], null: true

    def resolve(variant_id:, location_id:, inventory_item_condition_name:)
      inventory_items = Array.new
      item_atomic_states = Hash.new
      all_items_exist = true

      inventory_item_condition_id = InventoryItemCondition.find_by(name: inventory_item_condition_name).id
      variant = Variant.find(variant_id)

      # First check if the items of the variant exixts in the location
      #The operations must be atomic
      variant.items.each do |item|

        inventory_item = InventoryItem.find_by(location_id: location_id, item_id: item.id,
          inventory_item_state_id: InventoryItemState.find_by(name: "Available").id,
          inventory_item_condition_id: inventory_item_condition_id) || InventoryItem.find_by(location_id: location_id,
            item_id: item.id, inventory_item_state_id: InventoryItemState.find_by(name: "Critical Level").id,
            inventory_item_condition_id: inventory_item_condition_id)

            if inventory_item.nil?
              item_atomic_states[item] = "Not Exists"
              all_items_exist = false
              break
            else
              item_atomic_states[item] = inventory_item
            end
          end

          # Now sell the variant. We are sure the items that is making up variant exist
          all_items_exist && variant.items.each do |item|

            inventory_item = item_atomic_states[item]
            inventory_item_condition_id = inventory_item.inventory_item_condition_id
            inventory_item_state_id = inventory_item.inventory_item_state_id

            new_quantity = inventory_item.quantity - 1  > 0 ? inventory_item.quantity - 1 : 0

            if new_quantity <= inventory_item.quantity_warning_threshold && new_quantity > 0
              new_inventory_item_state_name = "Critical Level"
              inventory_item_state_id = InventoryItemState.find_by(name: new_inventory_item_state_name).id
            end

            if new_quantity == 0 #Item was the last one
              new_inventory_item_state_name = "Out of Stock"
              inventory_item_state_id = InventoryItemState.find_by(name: new_inventory_item_state_name).id
              new_inventory_item_condition_name = "Not Sellable"
              inventory_item_condition_id = InventoryItemCondition.find_by(name: new_inventory_item_condition_name).id
            end

            # Drop the quantity from Available state and update state to Critical Level
            begin
              if inventory_item.update(id: inventory_item.id,
                inventory_item_state: InventoryItemState.find(inventory_item_state_id),
                inventory_item_condition: InventoryItemCondition.find(inventory_item_condition_id),
                quantity: new_quantity)
                inventory_items.push( inventory_item)
              else
                { errors: inventory_item.errors.full_messages }
              end
            rescue StandardError
              puts 'there is a problem in update'
            end

            # Add to committed state

            inventory_item_state_id = InventoryItemState.find_by(name: "Committed").id
            inventory_item_condition_id = InventoryItemCondition.find_by(name: "Not Sellable").id
            inventory_item = InventoryItem.find_by(
              location_id: location_id,
              item_id: item.id,
              inventory_item_state_id: inventory_item_state_id,
              inventory_item_condition_id: inventory_item_condition_id)

              new_quantity = !inventory_item.nil? ? inventory_item.quantity + 1 :  1

              begin
                # if there is no inventory_item in that state yet
                if inventory_item.nil?
                  if in_it = InventoryItem.create!(
                    location: Location.find(location_id),
                    item: Item.find(item.id),
                    inventory_item_state: InventoryItemState.find(inventory_item_state_id),
                    inventory_item_condition: InventoryItemCondition.find(inventory_item_condition_id),
                    quantity: new_quantity,
                    quantity_warning_threshold: 0)
                    inventory_items.push(in_it)
                  else
                    { errors: inventory_item.errors.full_messages }
                  end
                  # if there is an invnetory_item in that state, update the quantity
                else
                  if inventory_item.update(id: inventory_item.id, quantity: new_quantity)
                    inventory_items.push( inventory_item)
                  else
                    { errors: inventory_item.errors.full_messages }
                  end
                end
              rescue StandardError
                puts 'there is a problem'
              end
            end
            {inventory_items: inventory_items}

          end
        end
      end
