class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :show]

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :sex)
  end

  def logged_in_user
    unless current_user
      redirect_to new_user_session_url
    end
  end
end
