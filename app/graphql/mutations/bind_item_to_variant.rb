module Mutations
  class BindItemToVariant < BaseMutation
    # arguments passed to the `resolved` method
    argument :item_id, ID, required: true
    argument :variant_id, ID, required: true

    # return type from the mutation
    type Types::ItemVariantType


    def resolve(item_id: nil, variant_id: nil)
      v = Variant.find(variant_id)
      i = Item.find(item_id)
      ItemVariant.create!(
        variant: v,
        item: i
      )
       # v.items.push(i)
       # i.variants << v

      # ItemVariant.create!(
      #   item: Item.find(item_id),
      #   variant: Variant.find(variant_id)
      # )
    end
  end
end
