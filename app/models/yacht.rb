class Yacht < ApplicationRecord
  has_many :services, dependent: :destroy
  has_many :service_types, through: :services

  has_many :equipments, dependent: :destroy
  has_many :equipment_types, through: :equipments

  belongs_to :user

  has_many_attached :photos

  validates :title, :description, :price_per_day, :bed_space, presence: true
  validates :lat, :long, presence: { message: 'Enter a valid location' }
end
