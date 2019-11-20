module Types
  class LocationType < BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :location_type, LocationTypeType, null: false
    field :address, String, null: false
    field :properties, GraphQL::Types::JSON, null: false
  end
end
