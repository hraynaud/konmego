FactoryBot.define do
  factory :endorsement do |f|
    f.association :endorser, :factory => :member
    f.association :endorsee, :factory => :member
    f.association :topic
  end
end
