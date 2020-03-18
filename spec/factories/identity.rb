FactoryBot.define do
  factory :identity do |f|
    sequence(:email) { |n| "foo#{n}@example.com" }
    password {"password"}


    #trait :email_nil do
      #email {nil}
    #end

    #trait :email_invalid do
      #email {"joe@"}
    #end

    #trait :password_nil do
      #password {nil}
    #end

    #trait :password_too_short do
      #password {1234}
    #end
  end
end
