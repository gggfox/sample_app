class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      forwarding_url = session[:forwarding_url]
      # Log the user in and redirect to the user's show page.
      reset_session # prevents session fixation attacks
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      session[:session_token] = user.session_token
      redirect_to forwarding_url || user
    else
      # Create an error message, the now method deletes the message after another request is made.
      flash.now[:danger] = 'Invalid email/password combination' #Not quite right!
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end