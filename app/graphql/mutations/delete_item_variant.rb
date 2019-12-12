module Mutations
  class DeleteItemVariant < BaseMutation
    # arguments passed to the `resolved` method
    argument :id, ID, required: true


    field :errors, [String], null: true

    def resolve(id:)
      # if context[:current_admin].nil?
      #   raise GraphQL::ExecutionError,
      #         "You need to authenticate to perform this action"
      # end

      itemvariant = ItemVariant.find(id)

      if itemvariant.destroy()
        { errors: nil }
      else
        { errors: itemvariant.errors.full_messages }
      end


    end
  end
end
