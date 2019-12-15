FactoryBot.define do
  factory :location do
    name {"#{Faker::Lorem.word} #{Faker::Lorem.word}"}
    location_type {LocationType.create(id: 150, name: "AAAA")}
  end
end
