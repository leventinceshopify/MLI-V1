module Mutations
  class CreateLocationType < BaseMutation
    # arguments passed to the `resolved` method
    argument :name, String, required: true



    # return type from the mutation
    type Types::LocationTypeType

    def resolve(name: nil)
      LocationType.create!(
        name: name,

      )
    end
  end
end
