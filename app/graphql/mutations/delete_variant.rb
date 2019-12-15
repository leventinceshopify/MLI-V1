module Mutations
  class DeleteVariant < BaseMutation
    # arguments passed to the `resolved` method
    argument :id, ID, required: true
    field :errors, [String], null: true

    def resolve(id:)
      variant = Variant.find(id)
      if variant.destroy()
        { errors: nil }
      else
        { errors: variant.errors.full_messages }
      end
    end
  end
end
