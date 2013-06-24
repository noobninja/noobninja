class RequestsController < ApplicationController
  before_filter :user_subscribed?

  def new
    @request = current_user.requests.new
    @request.meetings.build
  end

  def create
    @request = current_user.requests.new(params[:request])

    respond_to do |format|
      if @request.save
        format.html { redirect_to lessons_path, notice: 'Request was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  private
  def user_subscribed?
    if current_user.teacher?
      redirect_to edit_membership_path(current_user.membership), notice: "Help support NoobNinja by subscribing before requesting help."
    elsif !current_user.member?
      redirect_to new_membership_path, notice: "Help support NoobNinja by subscribing before requesting help."
    end
  end
end