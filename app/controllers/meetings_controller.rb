class MeetingsController < ApplicationController
  before_filter :set_meeting
  before_filter :user_subscribed?
  before_filter :meeting_booked?

  def show
  end

  def book_meeting
    if @meeting.booked?
      respond_to do |format|
        format.html { redirect_to @meeting, notice: 'Unfortunately, this lesson has already been booked.' }
      end
    else
      begin
        @customer = @lesson.type == "Request" ? @lesson.user : current_user

        Stripe::Charge.create(
          amount: @lesson.amount,
          currency: "usd",
          customer: @customer.membership.stripe_customer_id,
          description: "#{@customer.name} (#{@customer.email}) for #{@lesson.type} #{@lesson.id}"
        )

        @meeting.update_attributes(booked: true)
        @lesson.update_attributes(booked: true) if @lesson.type == "Request"
        @meeting.users << current_user

        respond_to do |format|
          format.html { redirect_to @meeting, notice: 'Lesson successfully booked.' }
        end

      rescue Stripe::InvalidRequestError => e
        redirect_to @meeting, notice: 'There was an error with your card. Please contact us at help@noobninja.com for assistance.'
      end
    end
  end

  private
  def set_meeting
    @meeting = Meeting.find(params[:id])
    @lesson = @meeting.lesson
  end

  def user_subscribed?
    if current_user.teacher? && @lesson.type != "Request"
      redirect_to edit_membership_path(current_user.membership), notice: "Help support NoobNinja by subscribing before requesting help."
    elsif !current_user.member? && @lesson.type != "Request"
      redirect_to memberships_path, notice: "Help support NoobNinja by subscribing before requesting help."
    end
  end

  def meeting_booked?
    if @lesson.booked? && !@meeting.users.include?(current_user)
      redirect_to lessons_path, notice: 'Unfortunately, this lesson has already been booked.'
    elsif @meeting.booked? && !@meeting.users.include?(current_user)
      redirect_to lessons_path, notice: 'Unfortunately, this meeting time has just been booked.'
    end
  end
end
