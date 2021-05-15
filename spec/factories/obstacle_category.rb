FactoryBot.define do
  factory :obstacle_category do
    description {" a real blocker"}
    sequence(:name) { |n| "problem_type #{n}" }
  end
end
