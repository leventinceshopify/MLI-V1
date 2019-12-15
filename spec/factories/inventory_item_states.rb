FactoryBot.define do
  factory :inventory_item_state do
    name {"#{Faker::Lorem.word} #{Faker::Lorem.word}"}
  end
end
