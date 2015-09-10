require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

places_inspace = ['Mercury', 'Venus', 'Mars', 'Earth', 'Jupiter', 'Saturn', 'Uranus', 'Neptune', 'Pluto', 'black hole', 'restaurant at the end of the universe', 'earth\'s moon', 'YourRope Moon on Jupiter']
meet_ups= [
  { title: Faker::Book.title, description: Faker::Lorem.sentence, location: places_inspace.sample},
  { title: Faker::Company.name, description: Faker::Lorem.sentence, location: places_inspace.sample},
  { title: Faker::Book.title, description: Faker::Lorem.sentence, location: places_inspace.sample},
  { title: Faker::Name.name, description: Faker::Lorem.sentence, location: places_inspace.sample},
  { title: Faker::Company.name, description: Faker::Lorem.sentence, location: places_inspace.sample},
  { title: Faker::Name.name, description: Faker::Lorem.sentence, location: places_inspace.sample}
]

meet_ups.each do |attributes|
  Meetup.create(attributes)
end


users = [
  { provider: Faker::App.name,
    uid: rand(10000..50000),
    username: Faker::Internet.user_name,
    avatar_url: Faker::Avatar.image,
    email: Faker::Internet.email },
  { provider: Faker::App.name,
    uid: rand(10000..50000),
    username: Faker::Internet.user_name,
    avatar_url: Faker::Avatar.image,
    email: Faker::Internet.email },
  { provider: Faker::App.name,
    uid: rand(10000..50000),
    username: Faker::Internet.user_name,
    avatar_url: Faker::Avatar.image,
    email: Faker::Internet.email }
  ]

    users.each do |attributes|
      User.create(attributes)
    end

# join table

join_table = [
  { meetup_id: 1,
    user_id: 3 },
  { meetup_id: 2,
    user_id: 1 },
  { meetup_id: 3,
    user_id: 1 },
  { meetup_id: 2,
    user_id: 3 }
]

join_table.each do |attributes|
  Usermeetup.create(attributes)
end
