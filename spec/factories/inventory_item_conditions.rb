FactoryBot.define do
  factory :inventory_item_condition do
    name {"#{Faker::Lorem.word} #{Faker::Lorem.word}"}
  end
end
