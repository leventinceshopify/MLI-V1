class Product < ApplicationRecord
  #aasociations
  has_many :variants , dependent: :destroy

  #validations. Add validations below
  validates :name, presence: true, length: { minimum: 3 }, uniqueness: { case_sensitive: true }

end
