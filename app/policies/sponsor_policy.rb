class SponsorPolicy < ApplicationPolicy
  def create?
    user.present? && user.admin?
  end

  def update?
    user.present? && (user.admin? || user.sponsor?)
  end

  def destroy?
    user.present? && user.admin?
  end
end
