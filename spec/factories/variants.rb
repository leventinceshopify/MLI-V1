FactoryBot.define do
  factory :variant do
    # id {34}
    name {"#{Faker::Lorem.word} #{Faker::Lorem.word}"}
    product {Product.create(id: 150, name: "AAAA")}
    # product {Product.create(name: Faker::Lorem.word)}

  end
end
