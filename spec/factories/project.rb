FactoryBot.define do
  factory :project do |f|
    f.association :owner, :factory => :member
    f.description {"This is a great project that will do great this"}
    f.name {"My Great Project"}

    trait :creatable do
      start_date {Date.today}
      deadline {1.month.from_now}
      with_topic
    end

    trait :valid do
      start_date {Date.today}
      deadline {1.month.from_now}
      with_obstacles
      with_topic
    end


    trait :with_topic do
      association :topic,  factory: :topic
    end
  end
end
