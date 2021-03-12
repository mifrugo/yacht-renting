class YachtPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def show?
    true
  end

  def user_list?
    true
  end

  def update?
    user == record.user
  end

  def favorite?
    true
  end

  def search?
    true
  end

  def user_favorite?
    true
  end

  def user_bookings?
    true
  end

  def review?
    user && (Booking.where(user_id: user.id, yacht_id: record.id, payment_status: 'paid') &&
    Review.where(user_id: user.id, yacht_id: record.id).blank?)
  end

  def destroy?
    user == record.user
  end
end
