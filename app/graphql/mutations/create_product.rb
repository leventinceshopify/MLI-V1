module Mutations
  class CreateProduct < BaseMutation
    # arguments passed to the `resolved` method
    argument :name, String, required: true
    argument :description, String, required: true
    argument :picture, String, required: false

    # return type from the mutation
    # type Types::ProductType
    field :product, Types::ProductType, null: true
    field :errors, [String], null: false

    def resolve(name: nil,  description: nil, picture: nil)
      # if context[:current_admin].nil?
      #   raise GraphQL::ExecutionError,
      #         "You need to authenticate to perform this action"
      # end

     product = Product.new(
       name: name,
       description: description,
       picture: picture
     )

      if product.save
        {product: product}
      else
        { errors: product.errors.full_messages }
      end


    end
  end
end
