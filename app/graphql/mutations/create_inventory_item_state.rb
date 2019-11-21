module Mutations
  class CreateInventoryItemState < BaseMutation
    # arguments passed to the `resolved` method
    argument :name, String, required: true
    argument :description, String, required: false


    # return type from the mutation
    type Types::InventoryItemStateType

    def resolve(name: nil, condition: nil, description: nil)
      InventoryItemState.create!(
        name: name,
        description: description
      )
    end
  end
end
