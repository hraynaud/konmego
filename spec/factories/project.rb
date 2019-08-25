FactoryBot.define do
  factory :project do |f|
    f.association :owner, :factory => :person
    f.description {"This is a great project that will do great this"}
    f.name {"My Great Project"}
  end
end
