class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates_presence_of :user_id, :friend_id
  validates_uniqueness_of :friend_id, scope: :user_id
  validate :friend_id_check

  protected

  def friend_id_check
    if friend_id == user_id
      errors.add(:friend_id, 'cannot be a friend with yourself.')
    end
  end
end
