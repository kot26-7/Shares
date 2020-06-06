class Post < ApplicationRecord
  belongs_to :user
  mount_uploader :post_image, PostImageUploader
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :post_image, presence: true
end
