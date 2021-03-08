class User < ApplicationRecord
  include CloudinaryHelper
  include Lavatar::Helpers
  include ActionView::Context

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_one_attached :avatar

  def navbar_avatar(size: 40)
    if avatar.attached?
      cl_image_tag(avatar.key, class: 'avatar')
    else
      lavatar_tag(first_name[0] << last_name[0], size, { class: 'avatar' })
    end
  end
end
