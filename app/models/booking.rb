class Booking < ApplicationRecord
  belongs_to :yacht
  belongs_to :user

  validates :from, :to, :price, presence: true
end
