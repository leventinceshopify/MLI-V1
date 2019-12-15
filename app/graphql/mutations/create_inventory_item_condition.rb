module Mutations
  class CreateInventoryItemCondition < BaseMutation
    # arguments passed to the `resolved` method
    argument :name, String, required: true

    type Types::InventoryItemConditionType
    def resolve(name: nil)
      InventoryItemCondition.create!(
        name: name,
      )
    end
  end
end
