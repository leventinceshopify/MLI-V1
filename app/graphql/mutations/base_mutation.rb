module Mutations
  # This class is used as a parent for all mutations, and it is the place to have common utilities

  class BaseMutation < GraphQL::Schema::Mutation

    #*********************************
    # get_item_in_this_state
    # CHECK IF AN INVENTORY_ITEM EXIST IN THIS STATE.
    # IF EXISTS, RETURN THE INVENTORY ITEM, ELSE RETURNS NIL
    #*********************************

    def check_availability_of_all_items(variant, location_id, condition_name, state_names)
      all_items_exist = true
      variant.items.each do |item|
        inventory_item = InventoryItem.find_by(
          location_id: location_id, item_id: item.id,
          inventory_item_state_id: state_names.map{|state| InventoryItemState.find_by(name: state).id},
          inventory_item_condition_id: InventoryItemCondition.find_by(name: condition_name).id)
          if inventory_item.nil?
            all_items_exist = false
            break
          end
        end
        return all_items_exist
      end

      def get_item_from_sellable_state(inventory_item_params)

        initial_condition = inventory_item_params[:inventory_item_condition_id]
        inventory_item_in_sellable_state = get_item_in_this_state(inventory_item_params, "Available")

        if inventory_item_in_sellable_state.nil?
          inventory_item_in_sellable_state = get_item_in_this_state(inventory_item_params, "Critical_Level")
        end
        if inventory_item_in_sellable_state.nil?
          inventory_item_params[:inventory_item_condition_id] =   InventoryItemCondition.find_by(name: "Not_Sellable" ).id
          inventory_item_in_sellable_state = get_item_in_this_state(inventory_item_params, "Out_of_Stock")
          inventory_item_params[:inventory_item_condition_id] = initial_condition
        end

        return inventory_item_in_sellable_state

      end


      def get_item_in_this_state(inventory_item_params, state = nil)

        return nil if (state.nil? || InventoryItemState.find_by(name: state).nil?) #No need to check if the  state is nil.

        item_state_id = InventoryItemState.find_by(name: state).id

        in_it = InventoryItem.find_by(item_id: inventory_item_params[:item_id],
          location_id: inventory_item_params[:location_id],
          inventory_item_state_id: item_state_id,
          inventory_item_condition_id: inventory_item_params[:inventory_item_condition_id])

          return nil if in_it.nil?

          return in_it
        end

        #*********************************
        # update_intial_state
        # IF THE INVENTORY ITEM IN THE initial STATE DOES NOT EXIST,
        # DOES NOTHING.
        # IF THE INVENTORY ITEM QUNATITY DROPS TO ZERO AFTER REMOVAL FROM THE
        # INITAL STATE, IT DECIDES TO DESTROY IT BASED ON allow_destroy_inital_state
        # FLAG. OTHERWISE JUST MODIFY THE QUANTIY ATTRIBUTE OF INVENTORY ITEM IN THAT
        # STATE
        #*********************************


        def update_initial_state(to_be_modified_inventory_item, dropped_quantity, allow_destroy_inital_state)

          return_params = Hash.new(0)
          return_params[:errors] = ""
          return_params[:dropped_count] = dropped_quantity

          if to_be_modified_inventory_item.nil?
            return_params[:inventory_item] = nil
            return_params[:dropped_count] = 0
            return return_params
          end

          new_quantity = (to_be_modified_inventory_item.quantity - dropped_quantity) >=0 ? (to_be_modified_inventory_item.quantity - dropped_quantity) : 0

          return_params[:dropped_count] = to_be_modified_inventory_item.quantity if new_quantity==0

          begin
            if new_quantity==0 && allow_destroy_inital_state
              if to_be_modified_inventory_item.destroy
                to_be_modified_inventory_item = nil
              else
                return_params[:errors] = to_be_modified_inventory_item.errors.full_messages
              end
            else
              if to_be_modified_inventory_item.update(id: to_be_modified_inventory_item.id, quantity: new_quantity)
                # inventory_item_array.push(inventory_item)
              else
                return_params[:errors] = to_be_modified_inventory_item.errors.full_messages
              end
            end
          rescue StandardError
            puts 'there is a problem in dropping incoming quantity from initial state'
          end

          return_params[:inventory_item] = to_be_modified_inventory_item
          return return_params
        end


        #*********************************
        # update_final_state
        # IF THE INVENTORY ITEM IN THE FINAL STATE DOES NOT EXIST,
        # CREATES A NEW INVENTORY ITEM, ELSE MODIFIY THE PASSED
        # INVENTORY ITEM.
        #*********************************

        def update_final_state(to_be_modified_inventory_item, inventory_item_params, next_state)

          return_params = Hash.new(0)
          count = inventory_item_params[:count]

          if to_be_modified_inventory_item.nil?

            result = create_inventory_item(inventory_item_params, next_state)
            return_params = result
          else
            new_quantity = to_be_modified_inventory_item.quantity + count
            begin
              if to_be_modified_inventory_item.update(id: to_be_modified_inventory_item.id, quantity: new_quantity, inventory_item_condition_id: inventory_item_params[:inventory_item_condition_id])
                return_params[:inventory_item] = to_be_modified_inventory_item
              else
                return_params[:errors] = inventory_item.errors.full_messages
              end

            rescue StandardError
              puts 'there is a problem in dropping incoming quantity from initial state'
            end
          end
          return return_params
        end

        def set_sellable_item_state(state_result)
        if !state_result[:inventory_item].nil?
            if (state_result[:inventory_item].quantity > state_result[:inventory_item].item.quantity_threshold)
              state_result[:inventory_item].update(id: state_result[:inventory_item].id, inventory_item_state: InventoryItemState.find_by(name: "Available"))


            elsif (state_result[:inventory_item].quantity == 0)
              state_result[:inventory_item].update(id: state_result[:inventory_item].id, inventory_item_state: InventoryItemState.find_by(name: "Out_of_Stock"), inventory_item_condition: InventoryItemCondition.find_by(name: "Not_Sellable"))
            else
              state_result[:inventory_item].update(id: state_result[:inventory_item].id, inventory_item_state: InventoryItemState.find_by(name: "CriticaL_Level"))

            end
          end
        end



        private
        #*********************************
        # create_inventory_item
        # CREATE A NEW INVENTORY ITEM ON THE
        # SPECIFIED STATE AND RETURN  IN ALONG
        # WITH ANY ERROR.

        #*********************************


        def create_inventory_item(to_be_created_inventory_item_params, state)
          return_params = Hash.new(0)

          begin
            if in_it = InventoryItem.create!(
              location: Location.find(to_be_created_inventory_item_params[:location_id]),
              item: Item.find(to_be_created_inventory_item_params[:item_id]),
              inventory_item_state: InventoryItemState.find_by(name: state),
              inventory_item_condition: InventoryItemCondition.find(to_be_created_inventory_item_params[:inventory_item_condition_id]),
              quantity: to_be_created_inventory_item_params[:count])


            else
              return_params[:errors] = inventory_item.errors.full_messages
              in_it = nil
            end
          rescue
            puts "there is a problem in creating inventory item in Committed state for Item: #{item.name} "
          end

          return_params[:inventory_item] = in_it
          return return_params


        end

        null false
      end
    end
