FactoryBot.define do
  factory :pokemon do
    sequence(:name)
    weight { 80 }
    external_id { 1 }
    height { 90 }
  end
end
