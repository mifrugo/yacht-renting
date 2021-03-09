class Yacht < ApplicationRecord
  # belongs_to :location

  validates :title, :description, :price_per_day, presence: true

  validates :lat, :long, presence: { message: 'Enter a valid location' }

  has_many_attached :photos
end
