class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  before_save { self.email = email.downcase }
  mount_uploader :profile_image, ProfileImageUploader
  validates :username, presence: true, length: { maximum: 50 }
  validates :fullname, presence: true, length: { maximum: 50 }
  validates :introduce, length: { maximum: 500}
  validates :phonenumber, length: { maximum: 18}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	#validates :username, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
