class UsersController < ApplicationController
  POSTS_PER_PAGE = 6
  before_action :authenticate_user!, only: [:edit, :update, :following, :followers]
  before_action :find_user, only: [:edit, :update, :show, :following, :followers]

  def edit
    redirect_to root_path unless @user == current_user
  end

  def update
    redirect_to root_path unless @user == current_user
    if @user.update_attributes(user_params)
      flash[:notice] = "ユーザー情報を更新しました。"
      redirect_to root_path
    else
      flash.now[:alert] = "ユーザー情報の更新に失敗しました。"
      render 'edit'
    end
  end

  def show
    @posts = @user.posts.includes(:likes).order(created_at: :desc).page(params[:page]).per(POSTS_PER_PAGE)
  end

  def following
    @title = "フォローしているユーザー"
    @users = @user.following.page(params[:page]).per(POSTS_PER_PAGE)
    render 'show_follow'
  end

  def followers
    @title = "フォローされているユーザー"
    @users = @user.followers.page(params[:page]).per(POSTS_PER_PAGE)
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :sex, :image)
  end

  def find_user
    @user = User.find_by_id(params[:id])
    unless @user
      flash[:alert] = "ユーザーが見つかりません"
      redirect_to root_path
    end
  end
end
