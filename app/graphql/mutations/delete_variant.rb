module Mutations
  class DeleteVariant < BaseMutation
    # arguments passed to the `resolved` method
    argument :id, ID, required: true


    field :errors, [String], null: true

    def resolve(id:)
      # if context[:current_admin].nil?
      #   raise GraphQL::ExecutionError,
      #         "You need to authenticate to perform this action"
      # end

      variant = Variant.find(id)

      if variant.destroy()
        { errors: nil }
      else
        { errors: variant.errors.full_messages }
      end


    end
  end
end
