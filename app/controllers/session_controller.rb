class SessionController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])   #this find_by should be an active record method

    if user && user.authenticate(params[:password])  # if a user present, and authenticate against their entered password (securepassword rails method)
      session[:user_id] = user.id   # then we set the id of the session equal to that of the users id 
      redirect_to movies_path, notice: "Welcome back, #{user.firstname}!"
    else
      flash.now[:alert] = "Login failed...please try again."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to movies_path, notice: "Sayonara!"
  end
end
