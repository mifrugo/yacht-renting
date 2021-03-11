class User < ApplicationRecord
  include CloudinaryHelper
  include Lavatar::Helpers
  include ActionView::Context

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_one_attached :avatar
  has_many :yachts, dependent: :destroy

  has_many :favorites
  has_many :favorite_yachts, through: :favorites, source: :yacht
  
  has_many :bookings
  has_many :booking_yachts, through: :bookings

  after_save :wipe_cache

  def first_name=(val)
    self[:first_name] = val.capitalize
  end

  def last_name=(val)
    self[:last_name] = val.capitalize
  end

  def full_name
    first_name << ' ' << last_name
  end

  def self.serialize_from_session(key, salt)
    user = Rails.cache.fetch("user:#{key.first}") do
      to_adapter.get(key)
    end

    return user if user && user.authenticatable_salt == salt

    super
  end

  def navbar_avatar(size: 40)
    if avatar.attached?
      cl_image_tag(avatar.key, class: 'avatar')
    else
      lavatar_tag(first_name[0] << last_name[0], size, { class: 'avatar' })
    end
  end

  private

  def wipe_cache
    Rails.cache.delete("user:#{id}")
  end
end
