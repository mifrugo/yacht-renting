class Location < ApplicationRecord
  has_many :yachts

  validates :name, presence: true
end
