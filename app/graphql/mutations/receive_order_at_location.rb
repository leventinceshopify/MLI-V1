# frozen_string_literal: true

module Mutations
  class ReceiveOrderAtLocation < BaseMutation
    # arguments passed to the `resolved` method
    argument :item_id, ID, required: true
    argument :location_id, ID, required: true
    argument :inventory_item_condition_name, String, required: true
    argument :quantity, Integer, required: true
    # return type from the mutation
    field :inventory_items, [Types::InventoryItemType], null: false
    field :errors, [String], null: true

    def resolve(item_id:, location_id:, quantity:, inventory_item_condition_name:)

      # Make sure there enough item in the incoming state
      items_exist = false
      inventory_items = Array.new
      inventory_item_state_id = InventoryItemState.find_by(name: "Incoming").id
      inventory_item_condition_id = InventoryItemCondition.find_by(name:  inventory_item_condition_name ).id
      item = Item.find(item_id)

      inventory_item = InventoryItem.find_by(
        location_id: location_id,
        item_id: item.id,
        inventory_item_state_id: inventory_item_state_id,
        inventory_item_condition_id: inventory_item_condition_id)

        if !inventory_item.nil?
          dropped_quantity = inventory_item.quantity >= quantity ? quantity : inventory_item.quantity
          items_exist = true
        end

        if items_exist
          # Update the incoming inventory_item quantity
          begin
            if (inventory_item.quantity - dropped_quantity)==0
              if inventory_item.destroy
              else
                { errors: inventory_item.errors.full_messages }
              end
            else
              if inventory_item.update(id: inventory_item.id, quantity: (inventory_item.quantity - dropped_quantity))
                inventory_items.push( inventory_item)
              else
                { errors: inventory_item.errors.full_messages }
              end
            end

          rescue StandardError
            puts 'there is a problem in dropping incoming quantity from incoming state'
          end

          # add to new available or critical level state. First find the inventory item
          # under mutually exclusive available, critical level and out of stock levels

          inventory_item = InventoryItem.find_by(location_id: location_id,
            item_id: item.id, inventory_item_state_id: [InventoryItemState.find_by(name: "Available"), InventoryItemState.find_by(name: "Critical Level"), InventoryItemState.find_by(name: "Out of Stock")],
            inventory_item_condition_id: inventory_item_condition_id)


            if inventory_item.nil?
              new_quantity =  dropped_quantity
              inventory_item_state_id = new_quantity <= item.quantity_threshold ? InventoryItemState.find_by(name: "Critical Level").id : InventoryItemState.find_by(name: "Available").id
              begin
                if in_it = InventoryItem.create!(
                  location: Location.find(location_id),
                  item: Item.find(item.id),
                  inventory_item_state:  InventoryItemState.find(inventory_item_state_id),
                  inventory_item_condition: InventoryItemCondition.find_by(name: "Normal"),
                  quantity: new_quantity)

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
