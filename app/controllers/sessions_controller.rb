class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
<<<<<<< HEAD
      if user.activated?
        forwarding_url = session[:forwarding_url]
        reset_session # prevents session fixation attacks
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to forwarding_url || user
      else
        message =  "Account not activated. "
        message += "Check your email for the activation link."
        flash[:danger] = message
        redirect_to root_url
      end
=======
      forwarding_url = session[:forwarding_url]
      # Log the user in and redirect to the user's show page.
      reset_session # prevents session fixation attacks
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      session[:session_token] = user.session_token
      redirect_to forwarding_url || user
>>>>>>> cb8d8d9e84c74c3ad8587e38939d47fecf27c93a
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
