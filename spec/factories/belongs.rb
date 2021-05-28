FactoryBot.define do
  factory :belong do
    name { Faker::Lorem.characters(number: 10) }
    address { Faker::Lorem.characters(number:10) }
    user
  end
end
