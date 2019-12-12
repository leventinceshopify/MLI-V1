module Mutations
  class CreateItem < BaseMutation
    # arguments passed to the `resolved` method
    argument :sku, Integer, required: true
    argument :name, String, required: true
    argument :description, String, required: true
    argument :cost, Float, required: true
    argument :quantity_threshold, Integer, required: true
    argument :size, String, required: true
    argument :manufacturer, String, required: true
    argument :picture, String, required: false

    # return type from the mutation
    type Types::ItemType

    def resolve(sku: nil, name: nil, description: nil,
      cost: nil, quantity_threshold: nil, size: nil, manufacturer: nil, picture: nil)
      item = Item.find_by(name: name)
      Item.create!(
        sku: sku,
        name: name,
        description: description,
        cost: cost,
        quantity_threshold: quantity_threshold,
        size: size,
        manufacturer: manufacturer,
        picture: picture
      ) if item.nil?
    end
  end
end
