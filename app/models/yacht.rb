class Yacht < ApplicationRecord
  belongs_to :location

  validates :title, presence: true
  validates :description, presence: true
  validates :booking_type, presence: true
end
