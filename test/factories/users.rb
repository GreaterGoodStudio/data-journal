FactoryGirl.define do
  factory :user do
    name        "Team Member"
    email       "team@example.com"
    password    "password"
    avatar      { Rack::Test::UploadedFile.new("#{Rails.root}/app/assets/images/default_avatar.png", "image/png") }
    admin       false

    factory :admin_user do
      name    "Admin User"
      email   "admin@example.com"
      admin   true
    end
  end
end
