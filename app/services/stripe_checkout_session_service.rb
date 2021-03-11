class StripeCheckoutSessionService
  def call(event)
    order = Booking.find_by(checkout_id: event.data.object.id)
    order.update(payment_status: 'paid')
  end
end
