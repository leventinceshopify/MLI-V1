module Mutations
  class DeleteInventoryItemCondition < BaseMutation
    # arguments passed to the `resolved` method
    argument :name, String, required: true

    field :errors, [String], null: true

    def resolve(name:)
      iic = InventoryItemCondition.find_by(name: name)
      if iic.destroy()
        { errors: nil }
      else
        { errors: iic.errors.full_messages }
      end
    end
  end
end
