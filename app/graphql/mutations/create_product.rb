module Mutations
  class CreateProduct < BaseMutation
    # arguments passed to the `resolved` method
    argument :name, String, required: true
    argument :description, String, required: true
    argument :picture, String, required: false

    type Types::ProductType


    def resolve(name: nil,  description: nil, picture: nil)
      product = Product.find_by(name: name)
      Product.create!(
       name: name,
       description: description,
       picture: picture
     )   if product.nil?

  end
end
end
