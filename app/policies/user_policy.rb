class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.order("name DESC")
      else
        nil
      end
    end
  end

  def index?
    user.admin?
  end

  def show?
    #security deactivated until friend feature built
    true
  end

  def collaborations?
    default_security
  end

  protected

  def friends_only
    # user.admin? ||  user_policy.rb needs refactor - requires friends feature to be completed
  end

  def default_security
    user.admin? || user == record
  end
end
