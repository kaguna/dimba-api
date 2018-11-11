class FixtureSquadPolicy < ApplicationPolicy
  def create?
    user.present? && (user.admin? || user.coach)
  end

  def update?
    user.present? && (user.admin? || user.coach)
  end

  def destroy?
    user.present? && (user.admin? || user.coach)
  end
end
