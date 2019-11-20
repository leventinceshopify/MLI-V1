module Mutations
  class CreateProduct < BaseMutation
    # arguments passed to the `resolved` method
    argument :name, String, required: true
    argument :description, String, required: true
    argument :picture, String, required: false

    # return type from the mutation
    type Types::ProductType

    def resolve(name: nil,  description: nil, picture: nil)
      Product.create!(
        name: name,
        description: description,
        picture: picture
      )
    end
  end
end
