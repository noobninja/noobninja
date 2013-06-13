class UsersController < ApplicationController
  def welcome
    redirect_to lessons_path if user_signed_in? && current_user.member?
  end

  def index
  end

  def show
  end
end
