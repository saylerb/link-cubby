class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])

    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:success] = "Successfully Logged In!"
      redirect_to root_path
    else
      flash.now[:danger] = "Invalid Credentials"
      render :new
    end
  end

  def destroy
    session.clear
    flash[:success] = "Successfully Logged Out"
    redirect_to login_path
  end
end
