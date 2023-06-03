FactoryBot.define do
  factory :person do |f|
    profile_image_url {""}
    avatar_url {""}
    factory :member do
      association :identity,  factory: :identity
      is_member {true}
    end

  end
end
