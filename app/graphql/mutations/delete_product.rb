module Mutations
  class DeleteProduct < BaseMutation
    # arguments passed to the `resolved` method
    argument :id, ID, required: true

    field :errors, [String], null: true

    def resolve(id:)
      product = Product.find(id)
      if product.destroy()
        { errors: nil }
      else
        { errors: product.errors.full_messages }
      end
    end
  end
end
