class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(session_params[:username], session_params[:password])
    if user
      login_user!(user)
      flash.notice = "Signed in"
      redirect_to user_url(user)
    else
      flash.now[:errors] = ["Username and Password don't match"]
      render :new
    end
  end

  def destroy
    logout_user!
    flash.notice = "Logged out"
    redirect_to new_session_url
  end

  private
  def session_params
    params.require(:session).permit(:username, :password)
  end

end
