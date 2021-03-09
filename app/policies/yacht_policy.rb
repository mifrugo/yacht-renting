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
    #if the user is the owner of the yacht => true
    #otherwise => false
    #user is current_user
    #record @yacht is (argument passed to authorize)
    user == record.user
  end

  def destroy
    user == record.user
  end
end
