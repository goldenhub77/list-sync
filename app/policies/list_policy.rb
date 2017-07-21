class ListPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all.order("title DESC")
      else
        scope.public.order("title DESC")
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

  protected

  def security_for_updating
    user.admin? or (record.user == user) or (user.role(record) == 'admin')
  end

  def member_security
    user.admin? or (record.user == user) or (user.role(record) == 'member')
  end

end
