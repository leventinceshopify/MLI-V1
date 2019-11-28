# frozen_string_literal: true

module Mutations
  class RemoveOrderOfItem < BaseMutation
    # arguments passed to the `resolved` method
    argument :item_id, ID, required: true
    argument :location_id, ID, required: true
    argument :quantity, Integer, required: true
    # return type from the mutation
    field :inventory_items, [Types::InventoryItemType], null: false
    field :errors, [String], null: true

    def resolve(item_id:, location_id:, quantity:)
      # Make sure there are enough item in the soruce location
      items_exist = false
      inventory_items = Array.new
      inventory_item_state_id = InventoryItemState.find_by(name: "Ordered").id
      item = Item.find(item_id)

      inventory_item = InventoryItem.find_by(
        location_id: location_id,
        item_id: item.id,
        inventory_item_state_id: inventory_item_state_id)


        if !inventory_item.nil?
          new_quantity = inventory_item.quantity >= quantity ? inventory_item.quantity - quantity : 0
          items_exist = true
        end


        if items_exist
          # Update the ordered inventory_item quantity
          if new_quantity == 0
            #Item was the last one in committed state.  Delete the record
            begin
              if inventory_item.destroy
              else
                { errors: inventory_item.errors.full_messages }
              end
            rescue StandardError
              puts 'there is a problem in destroying inventory item in ordered stast'
            end
          else
            # Drop the quantity from Available state and update state to Critical Level
            begin
              if inventory_item.update(id: inventory_item.id,
                inventory_item_state: InventoryItemState.find(inventory_item_state_id),
                quantity: new_quantity)
                inventory_items.push( inventory_item)
              else
                { errors: inventory_item.errors.full_messages }
              end


            rescue StandardError
              puts 'there is a problem in dropping  quantity from ordered state'
            end
          end

          end
          {inventory_items: inventory_items}
        end
      end
    end
