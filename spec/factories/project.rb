FactoryBot.define do
  factory :project do |f|
    f.association :owner, :factory => :person
    f.description {"This is a great project that will do great this"}
    f.name {"My Great Project"}

    trait :valid do
      with_criteria
      with_topic
    end

    trait :with_criteria do
      obstacles { build_list :obstacle, 3 }
    end

    trait :with_topic do
      association :topic,  factory: :topic
    end
  end
end
