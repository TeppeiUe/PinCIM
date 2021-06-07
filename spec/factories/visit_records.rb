FactoryBot.define do
  factory :visit_record do
    visit_datetime { Faker::Date.unique.between(from: '2021-05-01', to: '2021-06-30') }
    next_datetime { Faker::Date.between(from: '2021-05-01', to: '2021-06-30') }
    rank { "なし" }
    note { Faker::Lorem.characters(number: 50) }
    customer
    key_person
    sales_end
    belong
    user
  end
end
