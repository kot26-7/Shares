class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :notifications, dependent: :destroy
  validates :content, presence: true, length: { maximum: 50 }
  validates :user_id, presence: true
  validates :post_id, presence: true
end
