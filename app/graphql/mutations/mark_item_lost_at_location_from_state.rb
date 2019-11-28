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
      # Make sure there enough item in the incoming state
      items_exist = false
      inventory_items = Array.new
      inventory_item_state_id = InventoryItemState.find_by(name: inventory_item_state_name).id
      inventory_item_condition_id = InventoryItemCondition.find_by(name: inventory_item_condition_name).id
      item = Item.find(item_id)

      inventory_item = InventoryItem.find_by(
        location_id: location_id,
        item_id: item.id,
        inventory_item_state_id: inventory_item_state_id,
        inventory_item_condition_id: inventory_item_condition_id)

        if !inventory_item.nil?
          new_quantity = inventory_item.quantity - 1  > 0 ? inventory_item.quantity - 1 : 0
          items_exist = true
        end

        if items_exist
          # Update the  inventory_item quantity in the current state
            if inventory_item_state_name == "Available" || inventory_item_state_name == "Critical Level"
              if new_quantity <= item.quantity_threshold
                inventory_item_state_id =  InventoryItemState.find_by(name: "Critical Level").id
              elsif new_quantity == 0
                inventory_item_state_id =  InventoryItemState.find_by(name: "Out of Stock").id
              end
            end
            begin
            if inventory_item.update(id: inventory_item.id,
              inventory_item_state_id: inventory_item_state_id,
              quantity: new_quantity)
              inventory_items.push( inventory_item)
            else
              { errors: inventory_item.errors.full_messages }
            end

          rescue StandardError
            puts 'there is a problem in dropping incoming quantity from incoming state'
          end

          # add to new lost state. First check if the inventory item exist in lost list

          inventory_item_state_id = InventoryItemState.find_by(name: "Lost").id
          inventory_item = InventoryItem.find_by(location_id: location_id,
            item_id: item.id, inventory_item_state_id: inventory_item_state_id,
            inventory_item_condition_id: InventoryItemCondition.find_by(name: "Not Sellable").id)


            if inventory_item.nil?
              new_quantity =  1
              begin
                if in_it = InventoryItem.create!(
                  location: Location.find(location_id),
                  item: Item.find(item.id),
                  inventory_item_state:  InventoryItemState.find_by(name: "Lost"),
                  inventory_item_condition: InventoryItemCondition.find_by(name: "Not Sellable"),
                  quantity: new_quantity)

                  inventory_items.push(in_it)
                else
                  { errors: inventory_item.errors.full_messages }
                end
              rescue
                puts 'there is a problem in creating inventory item in Lost state'
              end

              # if there is an invnetory_item in that state, update the quantity
            else
              new_quantity = inventory_item.quantity + 1
              begin
                if inventory_item.update(id: inventory_item.id, inventory_item_state_id: inventory_item_state_id, quantity: new_quantity)
                  inventory_items.push( inventory_item)
                else
                  { errors: inventory_item.errors.full_messages }
                end
              rescue StandardError
                puts 'there is a problem in updating inventory item in Lost state'
              end
            end

          end
          {inventory_items: inventory_items}
        end
      end
    end
