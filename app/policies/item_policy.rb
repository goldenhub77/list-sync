class ItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.order("created_at DESC")
      else
        nil
      end
    end
  end

  def new?
    true
  end

  def create?
    user.admin? || member_security
  end

  def show?
    user.admin? || member_security
  end

  def edit?
    user.admin? || security_for_updating
  end

  def update?
    user.admin? || security_for_updating
  end

  def destroy?
    user.admin? || security_for_updating
  end

  def complete?
    user.admin? || member_security
  end

  protected

  def security_for_updating
    user.role(record.list) == 'admin' || record.user == user || record.list.user == user
  end

  def member_security
    user.role(record.list) == 'member' || record.user == user || record.list.user == user
  end

  #not 100% about how I want to handle this function yet
  # def item_completed_security
  #   (record.user == user) || (user.role(record.list) == 'admin') || (user.role(record.list) == 'member' and record.completed == false)
  # end
end
