FactoryBot.define do
  factory :invite do |f|
    status{"pending"}
    first_name{"invitee"}
    last_name{"invited"}
    email{"invitee@invited.com"}

    trait :with_topic do
      association :topic,  factory: :topic
    end
  end
end
