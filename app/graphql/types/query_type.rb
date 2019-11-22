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

# where(category: category).limit(10)

        # field :post, PostType, null: false do
        #   argument :post_id, ID, required: true, as: :id
        # end
        #
        # def post(id:)
        #   Post.find(id)
        # end




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
