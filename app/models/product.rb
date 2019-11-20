class Product < ApplicationRecord
  #aasociations
  has_many :variants , dependent: :destroy

  #validations. Add validations below


end
