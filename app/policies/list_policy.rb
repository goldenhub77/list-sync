class ListPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.order("title DESC")
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

  def join?
    join_security
  end

  protected

  def security_for_updating
    user.admin? || user.role(record) == 'admin' || record.user == user
  end

  def member_security
    user.admin? || user.role(record) == 'member' || record.user == user
  end

  def join_security
    user.role(record).nil? && record.public == true
  end
end
