class SessionsController < ApplicationController
  before_action :redirect_if_login, only: [:new]
  
  def new
    render :new
  end

  def create

    @user = User.find_by_credentials(
      session_params[:username],
      session_params[:password]
    )

    if @user.nil?
      render :new
    else
      log_in(@user)
      redirect_to cats_url
    end
  end

  def destroy
    log_out
    redirect_to new_session_url
  end

  private
  def session_params
    params.require(:session).permit(:username, :password)
  end
end
