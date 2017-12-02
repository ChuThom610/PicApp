class UsersController < ApplicationController
  before_action :logged_in_user
  # before_action :correct_user, only: [:show, :edit, :update]

  def show
    @user = current_user
    @albums = current_user.albums.all
  end
  
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to root_path, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:user_name)
  end
end