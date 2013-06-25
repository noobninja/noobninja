class UsersController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:welcome]

  def welcome
  end

  def index
  end

  def show
    @user = User.find(params[:id])
    @offers = @user.offers
    @requests = @user.requests
  end
end
