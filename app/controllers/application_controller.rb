class ApplicationController < ActionController::Base
  helper_method :ensure_logged_in
  helper_method :current_user
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    if session[:session_token]
      @current_user ||= User.find_by_session_token(session[:session_token])
    else
      nil
    end
  end

  def log_in! user
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def log_out!
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def ensure_logged_in
    redirect_to new_session_url if current_user.nil?
  end
end
