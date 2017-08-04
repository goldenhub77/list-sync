class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.order("name DESC")
    end
  end

  def index?
    true
  end

  def show?
    user.admin? || user == record || are_friends?
  end

  def collaborations?
    user.admin? || user == record
  end

  def lists?
    user.admin? || user == record
  end

  protected

  def are_friends?
    user.friends.where('users.id = ?', record.id).present?
  end
end
