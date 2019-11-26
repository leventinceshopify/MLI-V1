module Mutations
  class UpdateProduct < BaseMutation
    # arguments passed to the `resolved` method
    argument :id, ID, required: true
    argument :name, String, required: true
    argument :description, String, required: false
    argument :picture, String, required: false

    # return type from the mutation
    # type Types::ProductType
    field :product, Types::ProductType, null: true
    field :errors, [String], null: false

    def resolve(id:, name: nil,  description: nil, picture: nil)
      # if context[:current_admin].nil?
      #   raise GraphQL::ExecutionError,
      #         "You need to authenticate to perform this action"
      # end

      product = Product.find(id)

      if product.update(name: name, description: description, picture: picture)
        { product: product }
      else
        { errors: product.errors.full_messages }
      end

    end
  end
end
