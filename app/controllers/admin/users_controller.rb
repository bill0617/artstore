class Admin::UsersController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :admin_required


  def index
    @users = User.all
  end

  def convert_admin
    @user = User.find(params[:user_id])
    @user.is_admin = true
    @user.save
    redirect_to admin_users_path
  end

  def convert_user
    @user = User.find(params[:user_id])
    @user.is_admin = false
    @user.save
    redirect_to admin_users_path
  end

end
