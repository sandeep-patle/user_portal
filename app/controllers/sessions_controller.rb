class SessionsController < ApplicationController
  before_filter :authenticate_user, only: [:destroy]

  def new; end

  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password], header_options)
    if user.blank?
      flash[:error] = "Your email or password is invalid"
      redirect_to new_session_path
    else
      sign_in user
      redirect_to dashboard_path
    end
  end

  def destroy
    if User.destroy(@current_user.id, header_options)
      sign_out
      redirect_to new_session_path
    else
      redirect_to dashboard_path
    end
  end
end

