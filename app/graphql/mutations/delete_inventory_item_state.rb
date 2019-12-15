module Mutations
  class DeleteInventoryItemState < BaseMutation
    # arguments passed to the `resolved` method
    argument :name, String, required: true

    field :errors, [String], null: true
    def resolve(name:)
      iis = InventoryItemState.find_by(name: name)
      if iis.destroy()
        { errors: nil }
      else
        { errors: iis.errors.full_messages }
      end
    end
  end
end
