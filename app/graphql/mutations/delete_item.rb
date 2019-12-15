module Mutations
  class DeleteItem < BaseMutation
    # arguments passed to the `resolved` method
    argument :id, ID, required: true

    field :errors, [String], null: true

    def resolve(id:)
      item = Item.find(id)
      if item.destroy()
        { errors: nil }
      else
        { errors: product.errors.full_messages }
      end

    end
  end
end
