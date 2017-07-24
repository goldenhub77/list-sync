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
    user.admin? or user == record
  end
end
