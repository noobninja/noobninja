class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :authenticate_member!
  around_filter :user_time_zone, if: :current_user

  private

  def authenticate_member!
    redirect_to root_path if user_signed_in? && !current_user.member?
  end

  def user_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block)
  end
end
