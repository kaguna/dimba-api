class FixturesControllerPolicy < ApplicationPolicy
  def generate_fixture?
    user.present? && user.admin?
  end
end
