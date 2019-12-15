class Variant < ApplicationRecord
  belongs_to :product
  has_many :item_variants
  has_many :items, through: :item_variants

  validates :name, presence: true, length: { minimum: 3 }, uniqueness: { case_sensitive: true }
end
