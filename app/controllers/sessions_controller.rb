class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      log_in(user)  # Using helper to store session
      render json: { message: 'Logged in successfully', user: user }, status: :ok
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  def destroy
    log_out  # Using helper to reset session
    render json: { message: 'Logged out successfully' }, status: :ok
  end
end
