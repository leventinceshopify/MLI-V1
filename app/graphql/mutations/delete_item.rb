module Mutations
  class DeleteItem < BaseMutation
    # arguments passed to the `resolved` method
    argument :id, ID, required: true


    # return type from the mutation
    # type Types::ProductType
    # field :product, Types::ProductType, null: true
    field :errors, [String], null: true

    def resolve(id:)
      # if context[:current_admin].nil?
      #   raise GraphQL::ExecutionError,
      #         "You need to authenticate to perform this action"
      # end

      item = Item.find(id)

      if item.destroy()
        { errors: nil }
      else
        { errors: product.errors.full_messages }
      end


    end
  end
end
