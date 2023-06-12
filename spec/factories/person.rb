FactoryBot.define do
  factory :person do |f|
    profile_image_url {""}
    avatar_url {""}
    factory :member do

      is_member {true}

      sequence(:first_name) { |n| "foo#{n}" }
      sequence(:last_name) { |n| "bar#{n}" }
      sequence(:email) { |n| "foo#{n}@mail.com" }
      password {"passwordyword"}
    end

  end
end
