class Admin::UsersController < ApplicationController
  def index
    if current_user.admin?
      @users = User.all.page(params[:page]).per(10)
      render :index
    else
      not_admin_redirect
    end
  end

  def show 
    if current_user.admin?
      @users = User.find(params[:id])
      render :show
    else
      not_admin_redirect
    end
  end
end
