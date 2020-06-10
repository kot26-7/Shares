class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search

  def set_search
    @search = Post.ransack(params[:q])
    @search_posts = @search.result
  end
  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:fullname, :username])
    end

    def after_sign_up_path_for(resource)
      user_path(current_user)
    end

    def after_sign_in_path_for(resource)
      user_path(current_user)
    end
end
