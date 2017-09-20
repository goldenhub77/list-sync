class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         :omniauth_providers => [:facebook]

  mount_uploader :profile_picture, ProfilePictureUploader

  has_many :lists
  has_many :items
  has_many :lists_users, dependent: :destroy
  has_many :list_collaborations, source: :list, through: :lists_users, foreign_key: :list_id
  has_many :friends_users, dependent: :destroy
  has_many :friends, through: :friends_users
  has_many :completed_lists_items
  has_many :items_completed, source: :item, through: :completed_lists_items, foreign_key: :item_id

  validates :provider, presence: true, allow_blank: true
  validates :uid, presence: true, allow_blank: true
  validate :password_complexity
  validates :name, presence: true
  validates :admin, presence: true, allow_blank: true, inclusion: { in: [true, false] }
  validates :profile_picture, file_size: { less_than_or_equal_to: 3.megabytes },
                     file_content_type: { allow: ['image/jpeg', 'image/png'] }

  scope :all_active_users, -> { where('deleted_at IS NULL') }

  def role(list)
    begin
      lists_users.where('list_id = ?', list).first.role
    rescue ActiveRecord::StatementInvalid, ActiveRecord::RecordNotFound, NoMethodError => error
      return nil
    end
  end

  def has_no_friendship?(user)
    self != user && friends.where('friend_id = ?', user.id).empty?
  end

  #handled returned OAuth data to create a user
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.email = auth.info.email
      # user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.remote_profile_picture_url = auth.info.image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  # checks if user facebook data contains email when attempting to sign up through application
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.name = data["name"] if user.name.blank?
        user.email = data["email"] if user.email.blank?
        user.provider = session["devise.facebook_data"]["provider"]
        user.uid = session["devise.facebook_data"]['uid']
        user.remote_profile_picture_url = session["devise.facebook_data"]["info"]["image"]
      end
    end
  end

# if registering from LystSync directly this handles the password restrictions
  def password_complexity
    if provider.nil? && password.present? and not password.match(/^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=.\-_*!])([a-zA-Z0-9@#$%^&+=*.\-_!]){3,}$/)
      errors.add :password, "must include at least one lowercase letter, one uppercase letter, one digit, and one symbol"
    end
  end

  # instead of deleting, indicate the user requested a delete & timestamp it
  def soft_delete
    update_attribute(:deleted_at, Time.current)
  end

  # ensure user account is active
  def active_for_authentication?
    super && !deleted_at
  end

  # provide a custom message for a deleted account
  def inactive_message
  	!deleted_at ? super : :deleted_account
  end
end
