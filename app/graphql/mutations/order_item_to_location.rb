
module Mutations
  class OrderItemToLocation < BaseMutation
    # arguments passed to the `resolved` method
    argument :item_id, ID, required: true
    argument :location_id, ID, required: true
    argument :quantity, Integer, required: true
    # return type from the mutation
    field :inventory_items, [Types::InventoryItemType], null: false
    field :errors, [String], null: true

    def resolve(item_id:, location_id:, quantity:)
      inventory_items = Array.new
      inventory_item_state_id = InventoryItemState.find_by(name: "Ordered").id
      item = Item.find(item_id)

      inventory_item = InventoryItem.find_by(
        location_id: location_id,
        item_id: item.id,
        inventory_item_state_id: inventory_item_state_id)

        new_quantity = !inventory_item.nil? ? inventory_item.quantity + quantity :  quantity

          # if there is no inventory_item in that state yet
          if inventory_item.nil?
              begin
                if in_it = InventoryItem.create!(
                  location: Location.find(location_id),
                  item: Item.find(item.id),
                  inventory_item_state: InventoryItemState.find(inventory_item_state_id),
                  inventory_item_condition: InventoryItemCondition.find_by(name: "Not Sellable"),
                  quantity: new_quantity)

                  inventory_items.push(in_it)
                else
                  { errors: inventory_item.errors.full_messages }
                end
              rescue
                puts 'there is a problem in creating an order for the first time'
              end
          else # if there is an invnetory_item in that state, update the quantity
            begin
              if inventory_item.update(id: inventory_item.id, quantity: new_quantity)

                inventory_items.push( inventory_item)
              else
                { errors: inventory_item.errors.full_messages }
              end
            rescue StandardError
              puts 'there is a problem in updating order state of inventory_item'
            end
          end
      {inventory_items: inventory_items}
    end
  end
end
