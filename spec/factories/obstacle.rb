FactoryBot.define do
  factory :obstacle do |f|
   sequence(:description){|n| "Description #{n}"} 
    #f.notes {"I don't know where to start"}
  end
end
