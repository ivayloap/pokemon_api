FactoryBot.define do
  factory :type do
    sequence(:name)
    sequence(:url) { |n| "http://example-#{n}.com" }
  end
end
