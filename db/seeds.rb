# Users
default_password = "password"
User.create!(
  name: "Admin",
  email: "admin@example.com",
  password: default_password,
  password_confirmation: default_password,
  admin: true,
  remote_avatar_url: "https://www.gravatar.com/avatar/admin?d=identicon"
)
User.create!(
  name: "Moderator",
  email: "moderator@example.com",
  password: default_password,
  password_confirmation: default_password,
  remote_avatar_url: "https://www.gravatar.com/avatar/moderator?d=identicon"
)
members = Array.new(20) do |n|
  User.create!(
    name: "Team Member #{n + 1}",
    email: "team#{n + 1}@example.com",
    password: default_password,
    password_confirmation: default_password,
    remote_avatar_url: "https://www.gravatar.com/avatar/#{n}?d=identicon"
  )
end
User.update_all invitation_accepted_at: Time.now

# Projects
8.times do |n|
  project = Project.new(
    name: Faker::Lorem.sentence(2, false, 5).chomp("."),
    due_date: Faker::Date.between(1.week.from_now, 1.month.from_now),
    archived: n == 0
  )

  project_members = members.sample(rand(2..10))

  project_members.each_with_index do |member, index|
    project.memberships.new(member: member, moderator: index.zero?)
  end

  rand(1..project_members.count).times do
    session = project.sessions.new(
      name: Faker::Lorem.sentence(2, false, 5).chomp("."),
      date: Faker::Date.between(1.week.ago, Time.now),
      member: project_members.sample
    )

    rand(1..10).times do
      session.photos.new(image_processed: true)
    end

    rand(1..10).times do
      session.data_points.new(
        observation: Faker::Lorem.paragraph[0, 250],
        meaning: Faker::Lorem.paragraph[0, 115],
        photo: Photo.new(image_processed: true)
      )
    end
  end

  project.save!
end
