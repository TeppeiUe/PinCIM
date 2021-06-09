FactoryBot.define do
  factory :customer do
    name { Faker::Name.name }
    address { "" } # { Faker::Address.full_address }
    system { Faker::Lorem.characters(number: 10) }
    note { Faker::Lorem.characters(number: 50) }
    key_person
    sales_end
    user
  end
end
