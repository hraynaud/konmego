FactoryBot.define do
  factory :obstacle do |f|
   sequence(:description){|n| "Description #{n}"} 
   association :obstacle_category
  end
end
