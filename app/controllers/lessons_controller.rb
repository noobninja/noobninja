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

    @selected_tag = ActsAsTaggableOn::Tag.where(name: params[:tag]).first if params[:tag]
    @lesson_tags = (@lessons + @booked_lessons + @inactive_lessons).map(&:tags).flatten.uniq.sort { |x,y| x.name <=> y.name }
    @lesson_tags = @lesson_tags + [@selected_tag] if params[:tag]
  end

  def show
  end
end
