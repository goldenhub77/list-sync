class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve

    end
  end

  def collaborations?
    default_security
  end

  protected

  def default_security
    user.admin? || user == record
  end
end
