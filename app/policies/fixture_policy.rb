class FixturePolicy < ApplicationPolicy
  def create?
    user.present? && (user.admin? || user.official?)
  end

  def update?
    user.present? && user.admin?
  end

  def destroy?
    user.present? && user.admin?
  end

  def generate_fixture?
    user.present? && (user.admin? || user.official?)
  end
end
