class CommentsController < ApplicationController
  before_action :authenticate_user!
	def create
    @comment = Comment.new(comment_params)
    post = Post.find(params[:post_id])
    @comment.user_id = current_user.id
    @comment.post_id = post.id
    if @comment.save
    	flash[:success] = "Commented Succsessfully"
      redirect_back(fallback_location: root_path)
    else
    	flash[:alert] = "Comment Unsuccessfully"
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
