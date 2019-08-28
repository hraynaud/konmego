FactoryBot.define do
  factory :project do |f|
    f.association :owner, :factory => :person
    f.description {"This is a great project that will do great this"}
    f.name {"My Great Project"}

    trait :valid do
      with_criteria
    end

    trait :with_criteria do
      success_criteria { build_list :success_criterium, 3 }
    end
  end
end
