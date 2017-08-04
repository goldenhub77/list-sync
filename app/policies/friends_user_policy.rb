class FriendsUserPolicy < ApplicationPolicy
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
    user.admin? || friends_only
  end

  def remove?
    user.admin? || friends_only
  end

  protected

  def friends_only
    user == record.user
  end
end
