class PagesController < ApplicationController
  before_action :logged_in_user, only: :index

  def index
  end

  private

  def logged_in_user
    unless current_user
      redirect_to new_user_session_url
    end
  end
end
