class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments
  has_many :notifications, dependent: :destroy
  mount_uploader :post_image, PostImageUploader
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :post_image, presence: true

  #notifications of favorites
  def create_notification_favorite!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ",
                                  current_user.id, user_id, id, 'favorite'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'favorite'
      )

      if notification.visitor_id == notification.visited_id
         notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  #notifications of comments
  def create_notification_comment!(current_user, comment_id)
	    temp_ids = Comment.where(post_id: id).where.not("user_id=? or user_id=?", current_user.id,user_id).select(:user_id).distinct
	    temp_ids.each do |temp_id|
	      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
	    end
	    save_notification_comment!(current_user, comment_id, user_id)
	end

	def save_notification_comment!(current_user, comment_id, visited_id)
	    notification = current_user.active_notifications.new(
	      post_id: id,
	      comment_id: comment_id,
	      visited_id: visited_id,
	      action: 'comment'
	    )
	    if notification.visitor_id == notification.visited_id
	      notification.checked = true
	    end
	    notification.save if notification.valid?
	end
end
