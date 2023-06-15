FactoryBot.define do
  factory :person do |f|
    profile_image_url {""}
    avatar_url {""}
    sequence(:first_name) { |n| "foo#{n}" }
    sequence(:last_name) { |n| "bar#{n}" }
    sequence(:email) { |n| "foo#{n}@mail.com" }
    password {"passwordyword"}
    
    factory :registration do
      status{"pending"}
      reg_code {1234567890}
      reg_code_expiration {1.day.from_now}
    end

    factory :member do
      is_member {true}
    end

  end
end
