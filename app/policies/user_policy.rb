class UserPolicy < ApplicationPolicy
  def update?
    user.present? && user.admin?
  end

  def destroy?
    user.present? && user.admin?
  end
end
