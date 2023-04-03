FactoryBot.define do
  factory :plane do
    name { Faker::Vehicle.make_and_model }
    plane_type { 'Private' }
    description { Faker::Lorem.paragraph }
    image { 'https://example.com/plane.jpg' }
    price { Faker::Number.between(from: 10_000, to: 1_000_000) }
    model { Faker::Vehicle.model }
    year_of_manufacture { Faker::Date.between(from: 50.years.ago, to: Date.today) }
    life_span { Faker::Date.between(from: Date.today, to: 50.years.from_now) }
    fees { Faker::Number.between(from: 500, to: 5000) }
    user
  end
end
