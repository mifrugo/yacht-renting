class BookingsController < ApplicationController
  def index
  end

  def new
    @booking = Booking.new
    @yacht = Yacht.find(params[:id])
    authorize @booking
  end  
  
  def create
    @yacht = Yacht.find(params[:id])
    # @booking = Booking.create(yacht:@yacht, user:current_user, price:set_price)
    @booking = Booking.new(booking_params)
    @booking.yacht = @yacht
    @booking.user = current_user
    @booking.price = set_price
    @booking.save
    authorize @booking
    redirect_back fallback_location: yacht_path(@yacht), notice: 'Booked!'
  end

  def destroy
  end  

  private 

  def booking_params
    params.require(:booking).permit(:from, :to) 
  end

  def set_price
    @yacht.price_per_day * (Date.parse(params[:booking][:to]) - Date.parse(params[:booking][:from])).to_i
  end 

end    