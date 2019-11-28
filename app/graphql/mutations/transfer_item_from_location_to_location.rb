# frozen_string_literal: true

module Mutations
  class TransferItemFromLocationToLocation < BaseMutation
    # arguments passed to the `resolved` method
    argument :item_id, ID, required: true
    argument :source_location_id, ID, required: true
    argument :destination_location_id, ID, required: true
    argument :inventory_item_condition_name, String, required: true
    argument :quantity, Integer, required: true
    # return type from the mutation
    field :inventory_items, [Types::InventoryItemType], null: false
    field :errors, [String], null: true

    def resolve(item_id:, source_location_id:, destination_location_id:, quantity:, inventory_item_condition_name:)
      # Make sure there are enough item in the soruce location
      items_exist = false
      inventory_items = Array.new
      inventory_item_state_id = InventoryItemState.find_by(name: "Available").id
      inventory_item_condition_id = InventoryItemCondition.find_by(name:  inventory_item_condition_name ).id
      item = Item.find(item_id)

      inventory_item = InventoryItem.find_by(
        location_id: source_location_id,
        item_id: item.id,
        inventory_item_state_id: inventory_item_state_id,
        inventory_item_condition_id: inventory_item_condition_id)

        if inventory_item.nil?
          inventory_item_state_id = InventoryItemState.find_by(name: "Critical Level").id
          inventory_item = InventoryItem.find_by(
            location_id: source_location_id,
            item_id: item.id,
            inventory_item_state_id: inventory_item_state_id,
            inventory_item_condition_id: inventory_item_condition_id)
        end


        if !inventory_item.nil?
          new_quantity = inventory_item.quantity >= quantity ? inventory_item.quantity - quantity : 0
          dropped_quantity = inventory_item.quantity - new_quantity
          items_exist = true
        end


        if items_exist
          # Update the source location inventory_item quantity

          if new_quantity <= item.quantity_threshold && new_quantity > 0
            inventory_item_state_id = InventoryItemState.find_by(name: "Critical Level").id
          end

          if new_quantity == 0 #Item was the last one
            inventory_item_state_id = InventoryItemState.find_by(name: "Out of Stock").id
            inventory_item_condition_id = InventoryItemCondition.find_by(name: "Not Sellable").id
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
            puts 'there is a problem in dropping source quantity from source destination'
          end

          # add to new available or critical level state. First find the inventory item
          # under mutually exclusive available, critical level and out of stock levels

          inventory_item_condition_id = InventoryItemCondition.find_by(name:  inventory_item_condition_name ).id

          inventory_item = InventoryItem.find_by(location_id: destination_location_id,
            item_id: item.id, inventory_item_state_id: [InventoryItemState.find_by(name: "Available").id, InventoryItemState.find_by(name: "Critical Level").id, InventoryItemState.find_by(name: "Out of Stock").id],
            inventory_item_condition_id: inventory_item_condition_id)


            if inventory_item.nil?

              inventory_item_state_id = dropped_quantity <= item.quantity_threshold ? InventoryItemState.find_by(name: "Critical Level").id : InventoryItemState.find_by(name: "Available").id
              begin
                if in_it = InventoryItem.create!(
                  location: Location.find(destination_location_id),
                  item: Item.find(item.id),
                  inventory_item_state:  InventoryItemState.find(inventory_item_state_id),
                  inventory_item_condition: InventoryItemCondition.find(inventory_item_condition_id),
                  quantity: dropped_quantity)

                  inventory_items.push(in_it)
                else
                  { errors: inventory_item.errors.full_messages }
                end
              rescue
                puts 'there is a problem in creating inventory item in Available/Critical level state'
              end

              # if there is an invnetory_item in that state, update the quantity
            else
              new_quantity = inventory_item.quantity + dropped_quantity
              inventory_item_state_id = new_quantity <= item.quantity_threshold ? InventoryItemState.find_by(name: "Critical Level").id : InventoryItemState.find_by(name: "Available").id
              begin
                if inventory_item.update(id: inventory_item.id, inventory_item_state_id: inventory_item_state_id, quantity: new_quantity)
                  inventory_items.push( inventory_item)
                else
                  { errors: inventory_item.errors.full_messages }
                end
              rescue StandardError
                puts 'there is a problem in updating inventory item in Available/Critical level state'
              end
            end

          end
          {inventory_items: inventory_items}
        end
      end
    end
