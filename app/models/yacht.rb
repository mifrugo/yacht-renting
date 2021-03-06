class Yacht < ApplicationRecord
  include PgSearch::Model

  has_many :services, dependent: :destroy
  has_many :service_types, through: :services

  has_many :equipments, dependent: :destroy
  has_many :equipment_types, through: :equipments

  has_many :bookings
  has_many :booking_users, through: :bookings, source: :user

  belongs_to :user

  has_many_attached :photos

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, :description, :price_per_day, :bed_space, :address, presence: true
  validates :lat, :long, presence: { message: 'Enter a valid location' }

  pg_search_scope :search_name_and_description,
                  against: %i[title description address],
                  using: {
                    tsearch: { prefix: true }
                  }

  def user_can_review?(user)
    (Booking.where(user_id: user.id, yacht_id: id, payment_status: 'paid') &&
    Review.where(user_id: user.id, yacht_id: id).blank?)
  end
end
