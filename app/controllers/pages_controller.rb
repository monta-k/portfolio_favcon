class PagesController < ApplicationController
  before_action :authenticate_user!, only: :index

  def index
    @posts = current_user.feed.includes(:likes, :user).order(created_at: :desc)
  end

  private

  def logged_in_user
    unless current_user
      redirect_to new_user_session_url
    end
  end
end
