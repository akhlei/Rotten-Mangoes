class Admin::UsersController < ApplicationController
  def index
    if current_user.admin?
      @users = User.all.page(params[:page]).per(10)
      render :index
    else
      redirect_to root_path, notice: "Get out! You must be an admin to view that page!"
    end
  end
end
