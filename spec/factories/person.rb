FactoryBot.define do
  factory :person do |f|
    sequence(:first_name) { |n| "foo#{n}" }
    sequence(:last_name) { |n| "bar#{n}" }
    is_member {true}

    association :identity,  factory: :identity
  end
end
