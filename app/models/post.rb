class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments
  mount_uploader :post_image, PostImageUploader
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :post_image, presence: true
end
