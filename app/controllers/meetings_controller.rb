class MeetingsController < ApplicationController
  before_filter :set_meeting
  before_filter :user_subscribed?
  before_filter :show_booked_meeting?, only: [:show]
  before_filter :meeting_booked?, only: [:book_meeting]

  def show
  end

  def book_meeting
    @customer = @lesson.type == "Request" ? @lesson.user : current_user
    @description = params[:donate].present? || @lesson.donate == true ? "Donation - #{@lesson.donate == true ? @lesson.user.name : current_user.name} (#{@lesson.donate == true ? @lesson.user.email : current_user.email}) via #{@customer.name} (#{@customer.email}) for #{@lesson.type} #{@lesson.id}" : "#{@customer.name} (#{@customer.email}) for #{@lesson.type} #{@lesson.id}"

    if params[:free].present?
      current_user.increment!(:freebies)
    else
      begin
        @amount = @lesson.amount
        Stripe::Charge.create(
          amount: @amount,
          currency: "usd",
          customer: @customer.membership.stripe_customer_id,
          description: @description
        )
      rescue
        redirect_to @meeting, notice: "There was an error with #{@lesson.type == 'Request' ? 'the requester\'s' : 'your'} card. Please contact us at help@noobninja.com for assistance."
      end
    end


    if @lesson.donate == true
      @lesson.user.donations.create(charity: "charity: water", amount: @amount, lesson_id: @lesson.id, via_user_id: current_user.id, counted: true)
      current_user.donations.create(charity: "charity: water",amount: @amount, lesson_id: @lesson.id)
    elsif params[:donate].present?
      current_user.donations.create(charity: "charity: water",amount: @amount, lesson_id: @lesson.id, counted: true)
    end

    @lesson.update_attributes(booked: true) if @lesson.type == "Request"
    @meeting.update_attributes(booked: true)

    @meeting.users << current_user unless @meeting.users.include?(current_user)
    @meeting.users << @lesson.user unless @meeting.users.include?(@lesson.user)

    respond_to do |format|
      format.html { redirect_to @meeting, notice: 'Lesson successfully booked.' }
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
      redirect_to new_membership_path, notice: "Help support NoobNinja by subscribing before requesting help."
    end
  end

  def show_booked_meeting?
    if @lesson.booked? && !@meeting.users.include?(current_user)
      redirect_to lessons_path, notice: 'Unfortunately, this lesson has already been booked.'
    elsif @meeting.booked? && !@meeting.users.include?(current_user)
      redirect_to lessons_path, notice: 'Unfortunately, this meeting time has just been booked.'
    end
  end

  def meeting_booked?
    redirect_to lessons_path, notice: 'Unfortunately, this meeting time has just been booked.' if @meeting.booked?
  end
end
