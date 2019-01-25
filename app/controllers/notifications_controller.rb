class NotificationsController < ApplicationController
  before_action :correct_user, only: [:link_through]

  def link_through
    @notification.update(read: true)
    redirect_to post_comments_path(@notification.post)
  end

  private

  def correct_user
    @notification = Notification.find(params[:id])
    redirect_to root_path unless @notification.user == current_user
  end
end
