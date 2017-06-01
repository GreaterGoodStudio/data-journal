FactoryGirl.define do
  factory :user do
    sequence(:name)   { |n| "Team Member #{n}" }
    sequence(:email)  { |n| "team#{n}@example.com" }
    password          "password"
    avatar            { Rack::Test::UploadedFile.new("#{Rails.root}/app/assets/images/default_avatar.png", "image/png") }
    admin             false

    factory :admin_user do
      name    "Admin"
      email   "admin@example.com"
      admin   true
    end

    factory :moderator_user do
      name    "Moderator"
      email   "moderator@example.com"
    end
  end
end
