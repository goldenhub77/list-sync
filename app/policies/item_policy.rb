class ItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all.order("title DESC")
      else
        nil
      end
    end
  end

  def show?
    member_security
  end

  def edit?
    security_for_updating
  end

  def update?
    security_for_updating
  end

  def destroy?
    security_for_updating
  end

  def complete?
    member_security
  end

  protected

  def security_for_updating
    user.admin? or (record.user == user) or (user.role(record.list) == 'admin')
  end

  def member_security
    user.admin? or (record.user == user) or (user.role(record.list) == 'member')
  end

end
