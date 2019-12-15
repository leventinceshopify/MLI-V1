FactoryBot.define do
  factory :location_type do
    name {"#{Faker::Lorem.word} #{Faker::Lorem.word}"}
  end
end
