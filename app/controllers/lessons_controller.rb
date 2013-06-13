class LessonsController < ApplicationController
  def index
    if params[:type] && params[:tag]
      @lessons = Lesson.where(type: params[:type].capitalize).tagged_with(params[:tag]).with_available_meetings
    elsif params[:type]
      @lessons = Lesson.where(type: params[:type].capitalize).with_available_meetings
    elsif params[:tag]
      @lessons = Lesson.tagged_with(params[:tag]).with_available_meetings
    else
      @lessons = Lesson.with_available_meetings
    end

    @booked_lessons = Offer.includes(:user, :meetings).where("lessons.id NOT IN (?)", @lessons.map(&:id)).where("meetings.start_time >= ?", Time.zone.now).order("meetings.start_time")
    @inactive_lessons = Offer.includes(:user, :meetings).where("lessons.id NOT IN (?)", @lessons.map(&:id) + @booked_lessons.map(&:id))

    # .where.not(id: @lessons.map(&:id) + @booked_lessons.map(&:id))

# .where("meetings.start_time >= ?", Time.zone.now).order("meetings.start_time")
    # @lessons.tagged_with(params[:tag]) if params[:tag]
    # @lessons.where(type: params[:type].capitalize) if params[:type]


    #.with_available_meetings
    # @booked_lessons = Offer.includes(:user, :meetings).where.not(id: @lessons.map(&:id)).where("meetings.start_time >= ?", Time.zone.now).order("meetings.start_time")
    # @inactive_lessons = Offer.includes(:user, :meetings).where.not(id: @lessons.map(&:id) + @booked_lessons.map(&:id))
  end

  def show
  end
end
