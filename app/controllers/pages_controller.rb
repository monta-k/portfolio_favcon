class PagesController < ApplicationController
  before_action :authenticate_user!, only: :index

  def index
    @posts = current_user.feed.includes(:likes, :user).order(created_at: :desc)
  end
end
