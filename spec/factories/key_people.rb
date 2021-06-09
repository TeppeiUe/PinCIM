FactoryBot.define do
  factory :key_person do
    name { Faker::Name.name }
    career { Faker::Lorem.characters(number: 10) }
    note { Faker::Lorem.characters(number: 50) }
    user
  end
end
