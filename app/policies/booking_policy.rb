class BookingPolicy < ApplicationPolicy
    class Scope < Scope
      def resolve
        scope.all
      end
    end
  
    def create?
      true
    end
  
    def favorite?
      true
    end
  
    def add?
      true
    end
  
    def destroy?
      record.user_id == user.id
    end
    
    def user_bookings?
    true
    end

  end
  