FactoryBot.define do
  factory :task do
    visit_record
    title { Faker::Lorem.characters(number: 10) }
    content { Faker::Lorem.characters(number: 50) }
    deadline { Faker::Date.in_date_period(year: 2021, month: 7) }
    is_active { true }
    user
  end
end
