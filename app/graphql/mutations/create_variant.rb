module Mutations
  class CreateVariant < BaseMutation
    # arguments passed to the `resolved` method
    argument :name, String, required: true
    argument :product_id, ID, required: true
    argument :description, String, required: true
    argument :price, Float, required: true
    argument :size, String, required: true
    argument :picture, String, required: false


    type Types::VariantType

    def resolve(name: nil, product_id: nil, description: nil,
      price: nil, size: nil,  picture: nil)
      variant = Variant.find_by(name: name)
      Variant.create!(
        name: name,
        product: Product.find(product_id),
        description: description,
        price: price,
        size: size,
        picture: picture
      ) if variant.nil?
    end
  end
end
