class Booking < ApplicationRecord
  belongs_to :yacht
  belongs_to :user

  validates :from, :to, :price, presence: true
  scope :past, -> { where("bookings.to < ?", Date.today)}
  scope :upcoming, -> { where("bookings.to >= ?", Date.today)}  

  def past 
    
  end  
end
