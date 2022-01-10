class FixtureSquadPolicy < ApplicationPolicy
  def create?
    user.present? && (user.admin? || user.coach?)
  end

  def add_first_11?
    user.present? && (user.admin? || user.coach?)
  end

  def update?
    user.present? && (user.admin? || user.coach?)
  end

  def destroy?
    user.present? && (user.admin? || user.coach?)
  end
end
