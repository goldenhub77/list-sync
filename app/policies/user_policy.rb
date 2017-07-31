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

  # def new?
  #   true
  # end



  def index?
    user.admin?
  end

  def show?
    # REFACTOR WHEN FRIENDS FEATURE COMPLETED
    #security deactivated until friend feature built
    true
  end

  def collaborations?
    user.admin? || user == record
  end

  protected

  # def friends_only
  #   user.admin? ||  user_policy.rb needs refactor - requires friends feature to be completed
  # end
end
