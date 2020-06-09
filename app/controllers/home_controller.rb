class HomeController < ApplicationController
  def top
  	if user_signed_in?
  		user = current_user
      @users = user.following.order("created_at DESC")
      @comment = Comment.new
  	end
  end

  def terms
  end
end
