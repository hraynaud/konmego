FactoryBot.define do
  factory :invite do |f|
    status{"pending"}
    first_name{"invitee"}
    last_name{"invited"}
    email{"invitee@invited.com"}
    association :sender,  factory: :member
   
    trait :with_topic_name do
      topic_name{"Some Topic"}
    end

    trait :with_topic do
      association :topic,  factory: :topic
    end

    trait :with_member do
      association :receiver,  factory: :member
    end
  end
end
