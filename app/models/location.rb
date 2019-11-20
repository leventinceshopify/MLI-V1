class Location < ApplicationRecord
  belongs_to :location_type
  has_many :inventory_items , dependent: :destroy
end
