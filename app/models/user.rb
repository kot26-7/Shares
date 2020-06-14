class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :active_notifications, foreign_key:"visitor_id", class_name: "Notification", dependent: :destroy
  has_many :passive_notifications, foreign_key:"visited_id", class_name: "Notification", dependent: :destroy
  #validates users
  before_save { self.email = email.downcase }
  mount_uploader :profile_image, ProfileImageUploader
  VALID_NAME =  /\A[a-zA-Z0-9_]+\z/
  validates :username, presence: true, length: { maximum: 50 }, format: { with: VALID_NAME }
  validates :fullname, presence: true, length: { maximum: 50 }
  validates :introduce, length: { maximum: 500}
  validates :phonenumber, length: { maximum: 18}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  #validates :username, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:twitter, :facebook]

  def self.find_for_facebook_oauth(provider, uid, name, email, signed_in_resource=nil)
  user = User.where(:provider => provider, :uid => uid).first
  unless user
    user = User.create(:username => name,
                     :fullname => name,
                     :provider => provider,
                     :uid => uid,
                     :email => email,
                     :password => Devise.friendly_token[0,20]
                     )
  end
    return user
  end

  def self.find_for_twitter_oauth(provider, uid, name, email, signed_in_resource=nil)
  user = User.where(:provider => provider, :uid => uid).first
  unless user
    user = User.create(:username => name,
                     :fullname => name,
                     :provider => provider,
                     :uid => uid,
                     :email => email,
                     :password => Devise.friendly_token[0,20]
                     )
  end
    return user
  end

  def already_fav?(post)
    self.favorites.exists?(post_id: post.id)
  end

  # Follow user
  def follow(other_user)
    following << other_user
  end

  # Unfollow user
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Check already following?
  def following?(other_user)
    following.include?(other_user)
  end

  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
end
