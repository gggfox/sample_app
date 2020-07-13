class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      reset_session # prevents session fixation attacks
      login_url user
      redirect_to user
    else
      # Create an error message, the now method deletes the message after another request is made.
      flash.now[:danger] = 'Invalid email/password combination' #Not quite right!
      render 'new'
    end
  end

  def destroy
  end
end
