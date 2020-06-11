module NotificationsHelper
	def notification_form(notification)
    #通知を送ってきたユーザーを取得
    @visitor = notification.visitor
    #コメントの内容を通知に表示する
    @comment = nil
    @visitor_comment = notification.comment_id
    # notification.actionがfollowかlikeかcommentかで処理を変える
    case notification.action
    when 'follow'
      #aタグで通知を作成したユーザーshowのリンクを作成
      tag.a(notification.visitor.username, href: user_path(@visitor)) + '  following you'
    when 'favorite'
      tag.a(notification.visitor.username, href: user_path(@visitor)) + '  like your post'
    when 'comment' then
      #コメントの内容と投稿のタイトルを取得　      
      @comment = Comment.find_by(id: @visitor_comment)
      tag.a(@visitor.username, href: user_path(@visitor)) + '  has commented on your post'
  	end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
