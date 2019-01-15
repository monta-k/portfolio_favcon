class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :following, :followers]
  before_action :correct_user, only: [:edit, :update]

  def edit
  end

  def update
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

  def following
    @title = "フォローしているユーザー"
    @user = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = "フォローされているユーザー"
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :sex, :image)
  end

  def logged_in_user
    unless current_user
      redirect_to new_user_session_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless @user == current_user
  end
end
