class PagesController < ApplicationController
  POSTS_PER_PAGE = 6
  before_action :authenticate_user!, only: :index

  def index
    @posts = current_user.feed.includes(:likes, :user).order(created_at: :desc).page(params[:page]).per(POSTS_PER_PAGE)
  end
end
