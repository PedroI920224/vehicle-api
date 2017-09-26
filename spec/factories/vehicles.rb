FactoryGirl.define do
  factory :vehicle do
    brand_car { Faker::Lorem.word }
    year { Faker::Number.number(3) }
    color "RED"
    licence_plate "AAA-111"
  end
end
