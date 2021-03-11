class BookingsController < ApplicationController
  before_action :take_yacht, only: %i[create]
  before_action :dates_params, only: %i[create]
  before_action :check_dates, only: %i[create]
  before_action :check_booked, only: %i[create]

  def create
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

  def take_yacht
    @yacht = Yacht.find(params[:id])
  end

  def dates_params
    if params[:booking][:from].empty? || params[:booking][:to].empty?
      redirect_back fallback_location: yacht_path(@yacht), notice: 'Please specify the dates'
    else
      set_dates
    end
  end

  def set_dates
    @from = Date.parse(params[:booking][:from])
    @to = Date.parse(params[:booking][:to])
  end

  def check_dates
    if @to <= @from || @from < Date.today
      redirect_back fallback_location: yacht_path(@yacht), notice: 'Error, please check again the dates'
    end
  end

  def check_booked
    sql = <<-SQL
      bookings.from BETWEEN :start AND :end
      OR bookings.to BETWEEN :start AND :end
      OR :start BETWEEN bookings.from AND bookings.to
    SQL

    if Booking.where(sql, start: @from, end: @to).count.positive?
      redirect_back fallback_location: yacht_path(@yacht), notice: 'The yacht is not available in the selected dates'
    end
  end

  def set_price
    @yacht.price_per_day * (@to - @from).to_i
  end
end
