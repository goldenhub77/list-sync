class FriendPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        user.friends.order("name DESC")
      else
        nil
      end
    end
  end

  def index?
    user.admin? || friends_only
  end

  def show?
    # REFACTOR WHEN FRIENDS FEATURE COMPLETED
    #security deactivated until friend feature built
    true
  end

  protected

  def friends_only
    binding.pry
    user == record.user
  end
end
