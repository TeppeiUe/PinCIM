FactoryBot.define do
  factory :sales_end do
    name { Faker::Name.name }
    post { Faker::Lorem.characters(number: 10) }
    telephone_number { Faker::PhoneNumber.cell_phone }
    note { Faker::Lorem.characters(number: 50) }
    belong
    user
  end
end
