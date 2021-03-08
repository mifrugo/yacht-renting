class User < ApplicationRecord
  include CloudinaryHelper
  include Lavatar::Helpers
  include ActionView::Context

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_one_attached :avatar

  after_save :wipe_cache

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
