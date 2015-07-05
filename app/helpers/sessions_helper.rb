module SessionsHelper

  def sign_in(user)
    session[:auth_token] = user[:auth_token]
    session[:user_id] = user[:id]
  end

  def sign_out
    session[:auth_token] = nil
    session[:user_id] = nil
  end

  def user_from_token
    User.find(session[:user_id], header_options)
  end
end
