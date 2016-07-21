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
      @user = User.find(params[:id])
      render :show
    else
      not_admin_redirect
    end
  end

  def new
    if current_user.admin?
      @user = User.new
    else
      not_admin_redirect
    end
  end

  def edit
    if current_user.admin? 
      @user = User.find(params[:id])
    else
      not_admin_redirect
    end
  end

  # @user is a new movie passing in the parameters from this create page
  # if it properly saves, go to the all movies page, otherwise go to the 'new' page again
  def create
    if current_user.admin?
      @user = User.new(user_params)
      if @user.save
        redirect_to admin_users_path, notice: "User with email: #{@user.email} was successfully created!"
      else
        render :new # TODO: this needs to render the admin/new not the regular
      end
    else
      not_admin_redirect
    end
  end 

  def destroy
    if current_user.admin?
      @user = User.find(params[:id])
      @user.destroy
      UserMailer.deletion_email(@user)
      redirect_to admin_users_path, notice: "User #{@user.email} was successfully deleted."
    else
      not_admin_redirect
    end
  end

  protected

  def user_params
    params.require(:user).permit(
      :email, :firstname, :lastname, :password, :password_confirmation, :admin
    )
  end
end
