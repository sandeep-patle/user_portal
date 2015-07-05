class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  helper_method :current_user

  def authenticate_user
    redirect_to new_session_path if current_user.blank?
  end

  def current_user
    return nil if session[:auth_token].blank?
    @current_user ||= user_from_token
  end

  def header_options
    { auth_token: session[:auth_token] }
  end

end
