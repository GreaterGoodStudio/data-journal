FactoryGirl.define do
  factory :project do
    name      { Faker::Lorem.sentence }
    due_date  { Faker::Date.between(1.days.from_now, 30.days.from_now) }

    factory :archived_project do
      archived true
    end
  end
end
