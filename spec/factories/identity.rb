FactoryBot.define do
  factory :identity do |f|
    sequence(:first_name) { |n| "foo#{n}" }
    sequence(:last_name) { |n| "bar#{n}" }
    sequence(:email) { |n| "foo#{n}@example.com" }
    password {"passwordyword"}


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
