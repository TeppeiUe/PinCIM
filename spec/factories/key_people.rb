FactoryBot.define do
  factory :key_person do
    name { Faker::Name.name }
    post { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    sex { "女性" }
    note { Faker::Lorem.characters(number: 50) }
    user
  end
end
