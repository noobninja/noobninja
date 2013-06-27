class UsersController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:welcome]

  def welcome
  end

  def index
  end

  def show
    @user = User.find(params[:id])
    @donated = @user.donations.present? ? (@user.donations.map(&:amount).inject(:+) / 100) : 0

    @offers = @user.offers
    @requests = @user.requests

    @upcoming = Meeting.includes(:meeting_users).where("meeting_users.user_id = (?) AND meetings.start_time >= ?", current_user, Time.zone.now)
    @booked = Lesson.includes(:meetings, :meeting_users).where("meeting_users.user_id = ?", current_user)
  end
end
