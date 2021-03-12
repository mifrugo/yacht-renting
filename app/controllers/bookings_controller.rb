class BookingsController < ApplicationController
  before_action :take_yacht, only: %i[create]
  before_action :dates_params, only: %i[create]
  before_action :check_dates, only: %i[create]
  before_action :check_booked, only: %i[create]
  before_action :single_booking, only: %i[single_order]

  def create
    @booking = Booking.new(booking_params)
    @booking.yacht = @yacht
    @booking.user = current_user
    @booking.price = set_price
    @booking.save
    authorize @booking

    set_payment

    redirect_to booking_checkout_path(@booking), notice: 'Yacht booked 🎉'
  end

  def user_bookings
    @yachts = current_user.bookings
    @past = current_user.bookings.past
    @upcoming = current_user.bookings.upcoming

    authorize @yachts
  end

  private

  def single_booking
    @booking = current_user.bookings.find(params[:id])
    authorize @booking
  end

  def set_payment
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: @yacht.title, amount: @booking.price.ceil,
        images: [
          Cloudinary::Utils.cloudinary_url(@yacht.photos.first.key)
        ], currency: 'eur', quantity: 1
      }],
      success_url: booking_checkout_url(@booking),
      cancel_url: booking_checkout_url(@booking)
    )

    @booking.update(checkout_id: session.id)
  end

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
