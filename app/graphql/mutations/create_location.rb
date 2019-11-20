module Mutations
  class CreateLocation < BaseMutation
    # arguments passed to the `resolved` method
    argument :name, String, required: true
    argument :address, String, required: true
    argument :location_type_id, ID, required: true
    argument :properties, GraphQL::Types::JSON, required: false


    # return type from the mutation
    type Types::LocationType

    def resolve(name: nil, address: nil, location_type_id: nil,
      properties: nil)
      Location.create!(
        name: name,
        location_type: LocationType.find(location_type_id),
        address: address,
        properties: properties
      )
    end
  end
end
