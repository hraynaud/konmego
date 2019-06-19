FactoryBot.define do
  factory :endorsement do |f|
    f.association :endorser, :factory => :person
    f.association :endorsee, :factory => :person
    f.association :topic
  end
end
