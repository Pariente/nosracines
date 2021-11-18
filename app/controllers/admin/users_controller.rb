class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.all
    @users = @users.order(created_at: :desc).page params[:page]
  end

  def give_private_access
    user = User.find(params[:user_id])
    user.has_private_access = true
    user.save
    redirect_to admin_users_path
  end

  def revoke_private_access
    user = User.find(params[:user_id])
    user.has_private_access = false
    user.save
    redirect_to admin_users_path
  end

  def make_admin
    user = User.find(params[:user_id])
    user.admin = true
    user.save
    redirect_to admin_users_path
  end

  def revoke_admin
    user = User.find(params[:user_id])
    user.admin = false
    user.save
    redirect_to admin_users_path
  end
end