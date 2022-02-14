FactoryBot.define do
  factory :item do
    todo
    name { Faker::Lorem.character }
    done { false }
  end
end
