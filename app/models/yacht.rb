class Yacht < ApplicationRecord
  # belongs_to :location
  has_many :services
  has_many :equipments

  has_many_attached :photos

  SERVICES = %w[Captain Crew Catering].freeze
  EQUIPMENTS = %w[GPS Fridge Heating Inverter].freeze

  validates :title, :description, :price_per_day, presence: true

  validates :lat, :long, presence: { message: 'Enter a valid location' }

end
