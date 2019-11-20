module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :all_items, [ItemType], null: false,
          description: "Returns the list of items in the inventory"
      def all_items
        Item.all
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

      field :all_item_variants, [ItemVariantType], null: false,
            description: "Returns the list of item variants bindingsh"
      def all_item_variants
        ItemVariant.all
      end

      # field :all_locations, [LocationType], null: false,
      #       description: "Returns the list of locations where inventory is kept"
      # def all_locations
      #   Location.all
      # end



  end
end
