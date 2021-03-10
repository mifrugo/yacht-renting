class FavoritePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def user_favorite?
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
end
