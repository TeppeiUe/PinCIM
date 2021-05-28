FactoryBot.define do
  factory :activity do
    category { rand(0..3) }
    name { Faker::Lorem.characters(number: 10) }
    user
  end
end
