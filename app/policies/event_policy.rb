class EventPolicy < ApplicationPolicy
  def create?
    user.present? && (user.admin? || user.referee?)
  end

  def update?
    user.present? && (user.admin? || user.referee?)
  end

  def destroy?
    user.present? && user.admin?
  end
end