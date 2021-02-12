class TransferPolicy < ApplicationPolicy
  def create?
    user.present? && (user.admin? || user.official?)
  end

  def update?
    user.present? && (user.admin? || user.official?)
  end

  def destroy?
    user.present? && user.admin?
  end
end
