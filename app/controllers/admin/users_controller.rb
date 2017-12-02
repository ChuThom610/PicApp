class Admin::UsersController < ApplicationController
  before_action :logged_in_user
  before_action :require_admin
  # before_action :correct_user, only: [:show, :edit, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # UserMailer.welcome_user(@user).deliver
      flash[:success] = t("controller.users.success")
      redirect_to admin_users_url
    else
      flash.now[:danger] = t("controller.users.fail")
      render :new
    end 
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to admin_users_path, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    if @user.destroy
      flash[:success] = t("controller.users.success")
      redirect_to root_path
    else
      flash.now[:danger] = t("controller.users.fail")
      redirect_to admin_users_url
    end

    # @user.destroy
    # respond_to do |format|
    #   format.html { redirect_to root_url, notice: 'User was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  def lock
    @user = User.find_by(id: params[:user_id])
    @user.update_attribute(:lock, true)
    redirect_to admin_users_path
  end

  def unlock
    @user = User.find_by(id: params[:user_id])
    @user.update_attribute(:lock, false)
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :email)
      .merge(password: '123456')
  end
end
