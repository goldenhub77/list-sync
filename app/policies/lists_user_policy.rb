class ListsUserPolicy < ApplicationPolicy

  def join?
    list_collaboration_exists? && record.list.user == user.id
  end

  def leave?
    list_collaboration_exists? && member_security
  end

  protected

  def member_security
    user.id = record.user.id && (record.role == 'member' || record.role == 'admin')
  end

  def list_collaboration_exists?
    record.present?
  end
end
