FactoryBot.define do
  factory :person do |f|
    sequence(:email) { |n| "foo#{n}@example.com" }
    sequence(:first_name) { |n| "foo#{n}" }
    sequence(:last_name) { |n| "bar#{n}" }
    password {"password"}
    is_member {true}
    trait :non_member do
      is_member {false}
    end

    trait :email_nil do
      email {nil}
    end

    trait :email_invalid do
      email {"joe@"}
    end

    trait :password_nil do
      password {nil}
    end

    trait :password_too_short do
      password {1234}
    end
  end
end
