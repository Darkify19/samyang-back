class UsersController < ApplicationController
  
  # Display all users (index)
  def index
    @users = User.all
    render json: @users
  end

  # Show user details (show)
  def show
    @user = User.find(params[:id])
  end

  # Edit user (edit)
  def edit
    @user = User.find(params[:id])
  end

  # Update user details (update)
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'User updated successfully'
    else
      render :edit
    end
  end

  # Destroy user (delete)
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: 'User deleted successfully'
  end

  private

  # Strong params for user
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :gender, :birthdate)
  end
end
