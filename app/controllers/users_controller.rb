class UsersController < ApplicationController
  POSTS_PER_PAGE = 6
  before_action :authenticate_user!, only: [:edit, :update, :following, :followers]
  before_action :correct_user, only: [:edit, :update]

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:notice] = "ユーザー情報を更新しました。"
      redirect_to root_path
    else
      flash.now[:alert] = "ユーザー情報の更新に失敗しました。"
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.includes(:likes).order(created_at: :desc).page(params[:page]).per(POSTS_PER_PAGE)
  end

  def following
    @title = "フォローしているユーザー"
    @user = User.find(params[:id])
    @users = @user.following.page(params[:page]).per(POSTS_PER_PAGE)
    render 'show_follow'
  end

  def followers
    @title = "フォローされているユーザー"
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(POSTS_PER_PAGE)
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :sex, :image)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless @user == current_user
  end
end
