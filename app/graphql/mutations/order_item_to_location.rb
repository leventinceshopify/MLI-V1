# frozen_string_literal: true

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



        begin
          # if there is no inventory_item in that state yet
          if inventory_item.nil?

            if in_it = InventoryItem.create!(
              location: Location.find(location_id),
              item: Item.find(item.id),
              inventory_item_state: InventoryItemState.find(inventory_item_state_id),
              inventory_item_condition: InventoryItemCondition.find_by(name: "Not Sellable"),
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


        #check if the item is in critical Level



      {inventory_items: inventory_items}
    end
  end
end
