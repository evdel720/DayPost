class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  def index
    @users = User.excluding_archived.order(:email)
  end

  def show
  end

  def update
    if @user == current_user
      flash[:alert] = "You cannot make yourself as non-admin user."
    else
      @user.update(admin: !@user.admin)
    end
    redirect_to admin_user_path(@user)
  end

  def destroy
    if @user == current_user
      flash[:alert] = "You cannot archive yourself."
    else
      @user.update(archived_at: Time.now)
      flash[:notice] = "User has been archived."
    end

    redirect_to admin_users_path
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
