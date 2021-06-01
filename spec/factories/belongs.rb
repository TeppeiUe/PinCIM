FactoryBot.define do
  factory :belong do
    name { Faker::Lorem.characters(number: 10) }
    address { Faker::Address.full_address }
    user
  end
end
