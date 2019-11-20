class LocationType < ApplicationRecord
  has_many :locations , dependent: :destroy
end
