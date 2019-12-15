module Mutations
  class UpdateProduct < BaseMutation
    # arguments passed to the `resolved` method
    argument :id, ID, required: true
    argument :name, String, required: true
    argument :description, String, required: false
    argument :picture, String, required: false


    field :product, Types::ProductType, null: true
    field :errors, [String], null: false

    def resolve(id:, name: nil,  description: nil, picture: nil)

      product = Product.find(id)

      if product.update(name: name, description: description, picture: picture)
        { product: product }
      else
        { errors: product.errors.full_messages }
      end

    end
  end
end
