module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :all_items, [ItemType], null: false,
          description: "Returns the list of items in the inventory"
      def all_items
        Item.all
      end

      field :item, ItemType, null: false do
            description "Returns the particular item in the inventory"
              argument :id, ID, required:true
              # argument :name, String, required:false
            end
        def item(id:)
           Item.find(id)
           # Item.where(:id => id)
        end


        field :variant, VariantType, null: false do
              description "Returns the particular variant in the inventory"
                argument :id, ID, required:true
                # argument :name, String, required:false
              end
          def variant(id:)
             Variant.find(id)
             # Item.where(:id => id)
          end


      field :all_products, [ProductType], null: false,
            description: "Returns the list of products sold by the merchant"
      def all_products
        Product.all
      end

      field :all_variants, [VariantType], null: false,
            description: "Returns the list of variants sold by the merchant"
      def all_variants
        Variant.all
      end


      field :all_locations, [LocationType], null: false,
            description: "Returns the list of locations of the merchant"
      def all_locations
        Location.all
      end

      field :all_inventory_item_conditions, [InventoryItemConditionType], null: false,
            description: "Returns the list of inventory item conditions"
      def all_inventory_item_conditions
        InventoryItemCondition.all
      end

      field :all_inventory_item_states, [InventoryItemStateType], null: false,
            description: "Returns the list of inventory item states"
      def all_inventory_item_states
        InventoryItemState.all
      end


      field :all_item_variants, [ItemVariantType], null: false,
            description: "Returns the list of item variants bindingsh"
      def all_item_variants
        ItemVariant.all
      end

      field :show_inventory, [InventoryItemType], null: false,
            description: "Returns the list of all items in inventory"
      def show_inventory
        InventoryItem.all
      end

      field :show_inventory_per_location, [InventoryItemType], null: false do
            description "Returns the list of all items in inventory"
            argument :id, ID, required:true
          end
      def show_inventory_per_location(id:)
        InventoryItem.all.where(:location_id => id)
      end

      # field :all_locations, [LocationType], null: false,
      #       description: "Returns the list of locations where inventory is kept"
      # def all_locations
      #   Location.all
      # end

      field :me, Types::AdminType, null: true

     def me
      context[:current_admin]
     end

  end
end
