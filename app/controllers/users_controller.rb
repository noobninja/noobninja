class UsersController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:welcome]
  # skip_before_filter :authenticate_member!, only: [:welcome]

  def welcome
    # redirect_to lessons_path if user_signed_in? && current_user.member?
  end

  def index
  end

  def show
  end
end
