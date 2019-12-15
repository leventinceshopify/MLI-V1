module Mutations
  class DeleteItemVariant < BaseMutation
    # arguments passed to the `resolved` method
    argument :id, ID, required: true

    field :errors, [String], null: true

    def resolve(id:)
      itemvariant = ItemVariant.find(id)
      if itemvariant.destroy()
        { errors: nil }
      else
        { errors: itemvariant.errors.full_messages }
      end
    end
  end
end
