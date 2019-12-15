class LocationType < ApplicationRecord
  has_many :locations , dependent: :destroy

  validates :name, presence: true, length: { minimum: 3 }, uniqueness: { case_sensitive: true }
end
