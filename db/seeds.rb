require 'faker'

puts "Cleaning your database.."
Yacht.destroy_all
Location.destroy_all

puts "Creating your instances.."

10.times do
  Location.create!(
  name: Faker::Address.city
  )
end

30.times do
  location = Location.all.sample.id
  Yacht.create!(
  title: Faker::Team.name,
  description: Faker::Lorem.paragraphs,
  booking_type: rand(1..2),
  location_id: location
  )
end

puts "Your data is ready! 🍪"
