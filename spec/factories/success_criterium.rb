FactoryBot.define do
  factory :success_criterium do |f|
   sequence(:description){|n| "Description #{n}"} 
    f.notes {"Tell me everthything I need to know"}
  end
end
