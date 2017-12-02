class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  private
  def logged_in?
    current_user.present?
  end

  def logged_in_user
    if !logged_in?
    redirect_to new_session_path(resource_name)
    end
  end

  def require_admin
    unless current_user.admin?
      sign_out current_user
      redirect_to root_path
    end
  end

  # def correct_user
  #   @user = User.find_by(id: params[:id])
  #   redirect_to(root_url) unless current_user?(@user)
  # end

  # def require_change_password
  #   if current_user.first_password? && !current_user.admin?
  #     flash[:danger] = t("controller.application.change_password")
  #     redirect_to edit_change_password_url(current_user)
  #   end
  # end
end
