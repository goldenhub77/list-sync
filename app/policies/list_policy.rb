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

  def new?
    user.admin? || member_security
  end

  def create?
    true
  end

  def show?
    user.admin? || public_security || member_security
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

  def join?
    user.admin? || public_security
  end

  def leave?
    user.admin? || member_security
  end

  protected

  def security_for_updating
     user.role(record) == 'admin' || record.user == user
  end

  def member_security
    user.role(record) == 'member' || record.user == user
  end

  def public_security
    record.public == true
  end
end
