class Admin::UsersController < ApplicationController

before_action :authenticate_user!
before_action :admin_required
layout "admin"

  def index
    @users = User.all
  end

  def to_admin
    @user = User.find(params[:user_id])
    @user.is_admin = true
    @user.save
    redirect_to admin_users_path, notice: "已經成為管理員了"
  end

  def to_normal
    @user = User.find(params[:user_id])
    @user.is_admin = false
    @user.save
    redirect_to admin_users_path, notice: "已轉為一般會員"
  end
end
