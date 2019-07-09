FactoryBot.define do
  factory :person do |f|
    sequence(:email) { |n| "foo#{n}@example.com" }
    sequence(:first_name) { |n| "foo#{n}" }
    sequence(:last_name) { |n| "bar#{n}" }
    password {"foobar"}
    is_member {true}
    trait :non_member do
      is_member {false}
    end
  end
end
