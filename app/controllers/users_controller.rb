class UsersController < ApplicationController
  before_filter :authenticate_user, :except => [:new, :create]

  def new
    @user = User.new({})
  end

  def create
    @user = User.new(params[:user])
    if @user.valid? && @user.password_valid? && @user.save(header_options)
      flash[:success] = "Successfully Registered! Login using your credentials!"
      redirect_to new_session_path
    else
      flash[:error] = "The password and confirmation password do not match."
      render 'new'
    end
  end
end
