class SessionsController < ApplicationController
   layout "session"
  def new
   
  end

  def create
    session[:password] = params[:password]
    if
      session[:password] == "viking"
      redirect_to(:root, :notice => 'Sucessfully logged in')
    else
      redirect_to(login_path, :alert => 'Wrong password')
    end
  end

  def destroy
    reset_session
    redirect_to(:root, :notice => 'Sucessfully logged out')
  end
end
