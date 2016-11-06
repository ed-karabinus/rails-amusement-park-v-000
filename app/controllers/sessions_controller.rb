class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(name: params[:user][:name])
    if @user.try(:authenticate, params[:user][:password])
      session[:user_id] = @user.id
      current_user
      redirect_to user_path(@user)
    else
      redirect_to new_session_path
    end
  end

  def destroy
    if current_user
      session[:user_id] = nil
      @current_user = nil
    end
    redirect_to '/'
  end
end
