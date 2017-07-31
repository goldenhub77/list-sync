class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         :omniauth_providers => [:facebook]

  has_many :lists, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :lists_users, dependent: :destroy
  has_many :list_collaborations, source: :list, through: :lists_users, foreign_key: :list_id

  validates :provider, presence: true, allow_blank: true
  validates :uid, presence: true, allow_blank: true
  validate :password_complexity
  validates :name, presence: true
  validates :admin, presence: true, allow_blank: true, inclusion: { in: [true, false] }

  def role(list)
    begin
      lists_users.where('list_id = ?', list).first.role
    rescue ActiveRecord::StatementInvalid, ActiveRecord::RecordNotFound, NoMethodError => error
      return nil
    end
  end

  #handled returned OAuth data to create a user
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.profile_picture = auth.info.image #no functionality for this yet, but will be implemented
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
      end
    end
  end

# if registering from LystSync directly this handles the password restrictions
  def password_complexity
    if provider.nil? && password.present? and not password.match(/^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=.\-_*!])([a-zA-Z0-9@#$%^&+=*.\-_!]){3,}$/)
      errors.add :password, "must include at least one lowercase letter, one uppercase letter, one digit, and one symbol"
    end
  end
end
