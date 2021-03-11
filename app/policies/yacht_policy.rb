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

  def destroy?
    user == record.user
  end
end
