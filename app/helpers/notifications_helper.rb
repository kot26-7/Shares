module NotificationsHelper
  def notification_form(notification)
    @visitor = notification.visitor
    @comment = nil
    @visitor_comment = notification.comment_id
    case notification.action
    when 'follow'
      tag.a(notification.visitor.username, href: user_path(@visitor)) + '  following you'
    when 'favorite'
      tag.a(notification.visitor.username, href: user_path(@visitor)) + '  like your post'
    when 'comment' then
      @comment = Comment.find_by(id: @visitor_comment)
      tag.a(@visitor.username, href: user_path(@visitor)) + '  has commented on your post'
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
