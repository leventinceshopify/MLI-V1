module Mutations
  class UpdateVariant < BaseMutation
    # arguments passed to the `resolved` method
    argument :id, ID, required: true
    argument :name, String, required: true
    argument :product_id, ID, required: true
    argument :description, String, required: true
    argument :price, Float, required: true
    argument :size, String, required: true
    argument :picture, String, required: false

    # return type from the mutation
    # type Types::ProductType
    field :variant, Types::VariantType, null: true
    field :errors, [String], null: false

    def resolve(id:, name: nil, product_id: nil, description: nil,
      price: nil, size: nil,  picture: nil)
      # if context[:current_admin].nil?
      #   raise GraphQL::ExecutionError,
      #         "You need to authenticate to perform this action"
      # end

      variant = Variant.find(id)

      if variant.update(name: name, product_id: product_id, description: description, price: price, size: size, picture: picture)
        { variant: variant }
      else
        { errors: variant.errors.full_messages }
      end
    end
  end
end
