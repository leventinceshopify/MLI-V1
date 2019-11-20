module Mutations
  class CreateItem < BaseMutation
    # arguments passed to the `resolved` method
    argument :sku, Integer, required: true
    argument :name, String, required: true
    argument :description, String, required: true
    argument :cost, Float, required: true
    argument :size, String, required: true
    argument :manufacturer, String, required: true
    argument :picture, String, required: false

    # return type from the mutation
    type Types::ItemType

    def resolve(sku: nil, name: nil, description: nil,
      cost: nil, size: nil, manufacturer: nil, picture: nil)
      Item.create!(
        sku: sku,
        name: name,
        description: description,
        cost: cost,
        size: size,
        manufacturer: manufacturer,
        picture: picture
      )
    end
  end
end
