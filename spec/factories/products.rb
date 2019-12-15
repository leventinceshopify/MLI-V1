FactoryBot.define do
  factory :product do

    name {"#{Faker::Lorem.word} #{Faker::Lorem.word}"}
    description {Faker::Lorem.word}
  end
end
