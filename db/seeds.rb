require 'faker'

puts "Cleaning your database.."

Equipment.destroy_all
Service.destroy_all

Yacht.destroy_all
# Location.destroy_all
EquipmentType.destroy_all
ServiceType.destroy_all
User.destroy_all

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

  User.create!(first_name: 'Michele', last_name: 'Frugoli', email: 'michele@frugo.li', password: 'ciaobello')

30.times do
  yacht = Yacht.create!(
    title: Faker::Team.name,
    description: Faker::Lorem.paragraphs.first,
    user_id: 1,
    bed_space: rand(1..12),
    price_per_day: rand(50..100),
    lat: Faker::Address.latitude,
    long: Faker::Address.longitude
  )

  Equipment.create!(
    yacht: yacht,
    equipment_type: EquipmentType.all.sample
  )

  Service.create!(
    yacht: yacht,
    service_type: ServiceType.all.sample
  )
end

puts "Your data is ready! 🍪"
