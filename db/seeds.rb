require 'faker'

puts "Cleaning your database.."

LOCATIONS =  [
  { name: 'Bari', longitude: '41.117142', latitude: '16.871872' },
  { name: 'Marseille', longitude: '43.295021', latitude: '5.374490' },
  { name: 'Ibiza', longitude: '38.90889', latitude: '1.43278' },
]

Equipment.destroy_all
Service.destroy_all

Yacht.destroy_all
# Location.destroy_all
EquipmentType.destroy_all
ServiceType.destroy_all
User.destroy_all

puts "Resetting the tables..."
ActiveRecord::Base.connection.reset_pk_sequence!('users')
ActiveRecord::Base.connection.reset_pk_sequence!('yachts')
ActiveRecord::Base.connection.reset_pk_sequence!('equipment_types')
ActiveRecord::Base.connection.reset_pk_sequence!('service_types')
ActiveRecord::Base.connection.reset_pk_sequence!('services')
ActiveRecord::Base.connection.reset_pk_sequence!('equipments')

puts "Creating your instances.."

# 10.times do
#   Location.create!(
#   name: Faker::Address.city
#   )
# end

  %w[Captain Crew Catering].each do |k|
    ServiceType.create!(name: k)
  end

  %w[GPS Fridge Heating Inverter].each do |k|
    EquipmentType.create!(name: k)
  end

  5.times do
    User.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      password: 'helloworld'
    )
  end

5.times do

  location = LOCATIONS.sample

  yacht = Yacht.create!(
    title: Faker::Team.name,
    description: Faker::Lorem.sentence(word_count: rand(100..200)),
    user_id: User.all.sample.id,
    bed_space: rand(1..12),
    price_per_day: rand(5000..10000),
    lat: location[:latitude],
    long: location[:longitude],
    address: location[:name],
  )

  yacht.photos.attach(io: File.open(Rails.root.join('public', 'images', "yacht#{rand(1..6)}.jpeg")), filename: 'yacht.jpeg')

  2.times do
    yacht.photos.attach(io: File.open(Rails.root.join('public', 'images', 'interior', "#{rand(1..8)}.jpg")), filename: 'interior.jpeg')
  end

  Equipment.create!(
    yacht: yacht,
    equipment_type: EquipmentType.all.sample
  )

  Service.create!(
    yacht: yacht,
    service_type: ServiceType.all.sample
  )
end

puts "Flushing cache..."
Rails.cache.redis.flushall

puts "Your data is ready! 🍪"
