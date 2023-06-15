#FIXME delete this file: 
FactoryBot.define do
  factory :registration_old do |f|
    status{"pending"}
    reg_code {1234567890}
    reg_code_expiration {1.day.from_now}
    association :identity,   factory: :identity

    trait :confirmed do
      status{"confiremd"}
    end
  end
end
