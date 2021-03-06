class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
   protect_from_forgery with: :exception
  helper_method :current_user

  def log_in(user)
    session[:session_token] = user.session_token
  end

  def log_out
    unless current_user.nil?
      current_user.reset_session_token!
      session[:session_token] = nil
    end
  end

  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def redirect_if_login
    redirect_to cats_url unless session[:session_token].nil?
  end

  def check_login_status
    redirect_to new_user_url if session[:session_token].nil?
  end
end
