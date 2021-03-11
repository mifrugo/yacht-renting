class Yacht < ApplicationRecord
  # include PgSearch::Model

  has_many :services, dependent: :destroy
  has_many :service_types, through: :services

  has_many :equipments, dependent: :destroy
  has_many :equipment_types, through: :equipments

  has_many :bookings
  has_many :booking_users, through: :bookings, source: :user

  belongs_to :user

  has_many_attached :photos

  has_many :reviews, dependent: :destroy

  validates :title, :description, :price_per_day, :bed_space, :address, presence: true
  validates :lat, :long, presence: { message: 'Enter a valid location' }


  pg_search_scope :search_name_and_description,
                  against: %i[title description],
                  using: {
                    tsearch: { prefix: true }
                  }

  def self.can_review?(yacht, user)
   !Booking.where("user_id =? and yacht_id =?", user, yacht).blank?
  end
end
