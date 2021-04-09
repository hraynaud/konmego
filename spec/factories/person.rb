FactoryBot.define do
  factory :person do |f|
    sequence(:first_name) { |n| "foo#{n}" }
    sequence(:last_name) { |n| "bar#{n}" }
    association :identity,  factory: :identity

    factory :member do
      is_member {true}
    end

  end
end
