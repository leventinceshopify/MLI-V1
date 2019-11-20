module Types
  class LocationTypeType < BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :locations, [LocationType], null: false
  end
end
