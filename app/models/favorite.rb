class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :yacht

  validates :user_id, uniqueness: { scope: :yacht_id }
end
