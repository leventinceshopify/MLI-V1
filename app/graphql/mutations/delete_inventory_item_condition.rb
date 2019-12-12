module Mutations
  class DeleteInventoryItemCondition < BaseMutation
    # arguments passed to the `resolved` method
    argument :name, String, required: true


    # return type from the mutation
    # type Types::ProductType
    # field :product, Types::ProductType, null: true
    field :errors, [String], null: true

    def resolve(name:)
      # if context[:current_admin].nil?
      #   raise GraphQL::ExecutionError,
      #         "You need to authenticate to perform this action"
      # end

      iic = InventoryItemCondition.find_by(name: name)

      if iic.destroy()
        { errors: nil }
      else
        { errors: iic.errors.full_messages }
      end


    end
  end
end
