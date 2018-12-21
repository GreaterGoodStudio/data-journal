FactoryBot.define do
  factory :project do
    name      { Faker::Lorem.sentence }
    due_date  { Faker::Date.between(1.days.from_now, 30.days.from_now) }

    after :build do |project|
      project.members << build(:user)
    end

    trait :archived do
      archived { true }
    end
  end

  factory :project_membership do
    association :project
    association :member, factory: :user
  end
end
