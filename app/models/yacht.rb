class Yacht < ApplicationRecord
  # belongs_to :location
  has_many :services, dependent: :destroy
  has_many :equipments, dependent: :destroy

  belongs_to :user

  has_many_attached :photos

  SERVICES = %w[Captain Crew Catering].freeze
  EQUIPMENTS = %w[GPS Fridge Heating Inverter].freeze

  validates :title, :description, :price_per_day, presence: true

  validates :lat, :long, presence: { message: 'Enter a valid location' }

  validates :bed_space, presence: true
end
