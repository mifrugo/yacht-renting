class ServiceType < ApplicationRecord
  has_many :yachts, through: :services
end
