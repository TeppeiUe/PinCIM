FactoryBot.define do
  factory :activity do
    category { "プレゼン" }
    name { Faker::Lorem.characters(number: 10) }
    user
  end
end
