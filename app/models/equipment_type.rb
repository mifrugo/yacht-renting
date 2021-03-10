class EquipmentType < ApplicationRecord
  has_many :yachts, through: :equipments
end
