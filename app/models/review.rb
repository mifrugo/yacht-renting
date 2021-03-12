class Review < ApplicationRecord
  belongs_to :yacht
  belongs_to :user

  validates :content, presence: true
  validates :rating, inclusion: 1..5
end
