FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Canon (#{n})" }
    sequence(:description) { |n| "DSLR (#{n})" }
  end
end
