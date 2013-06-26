class RequestsController < ApplicationController
  before_filter :user_subscribed? , only: [:new]
  before_filter :authenticate_request_user!, only: [:edit]
  def new
    @request = current_user.requests.new
    @request.meetings.build
    @lesson = Lesson.find(params[:lesson]) if params[:lesson]
  end

  def create
    @request = current_user.requests.new(params[:request])

    respond_to do |format|
      if @request.save
        if params[:request][:user_to_notify].present?
          @user = User.find(params[:request][:user_to_notify])
          UserMailer.meeting_request_email(current_user, @user, @request).deliver
        end
        format.html { redirect_to lessons_path, notice: "Request was successfully created #{"and #{@user.name} was notified"}." if params[:request][:user_to_notify].present?}
      else
        format.html { render action: "new" }
      end
    end
  end

  def edit
    @request = Request.find(params[:id])
  end

  def update
    @request = Request.find(params[:id])

    respond_to do |format|
      if @request.update_attributes(params[:request])
        format.html { redirect_to current_user, notice: 'Lesson was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  private
  def authenticate_request_user!
    @request = Request.find(params[:id])
    redirect_to root_path, notice: "You must be the owner of the lesson in order to edit it." unless current_user == @request.user
  end

  def user_subscribed?
    if current_user.teacher?
      redirect_to edit_membership_path(current_user.membership), notice: "Help support NoobNinja by subscribing before requesting help."
    elsif !current_user.member?
      redirect_to new_membership_path, notice: "Help support NoobNinja by subscribing before requesting help."
    end
  end
end