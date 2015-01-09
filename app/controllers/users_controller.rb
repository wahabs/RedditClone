class UsersController < ApplicationController
  before_action :ensure_logged_in, only: :show

  def create
    @user = User.new(user_params)
    if @user.save!
      redirect_to user_url
      log_in! @user
    else
      render :new
    end
  end

  def new
    @user = User.new
  end

  def show
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
