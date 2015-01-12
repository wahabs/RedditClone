class SessionsController < ApplicationController
  before_action :ensure_logged_in, only: :destroy

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
    if @user
      log_in! @user
      redirect_to user_url
    else
      @user = User.new(email: params[:user][:email])
      render :new
    end
  end


  def destroy
    log_out!
    redirect_to new_session_url
  end

end
