class ListsUserPolicy < ApplicationPolicy

  def leave?
    list_member?
  end

  protected

  def list_member?
    record.present? && user.id = record.user.id && (record.role == 'member' || record.role == 'admin')
  end
end
