class LessonsController < ApplicationController
  def index
    if params[:type] && params[:tag]
      @lessons = params[:type].capitalize.constantize.where(booked: false).tagged_with(params[:tag]).with_available_meetings
    elsif params[:type]
      @lessons = params[:type].capitalize.constantize.where(booked: false).with_available_meetings
    elsif params[:tag]
      @lessons = Lesson.where(booked: false).tagged_with(params[:tag]).with_available_meetings
    else
      @lessons = Lesson.where(booked: false).with_available_meetings
    end

    if @lessons.blank?
      if params[:type] == "request"
        @inactive_lessons = nil
      elsif params[:tag]
        @inactive_lessons = Offer.includes(:user, :meetings).tagged_with(params[:tag])
      else
        @inactive_lessons = Offer.includes(:user, :meetings).all
      end
    else
      if params[:tag]
        @inactive_lessons = Offer.includes(:user, :meetings).where("lessons.id NOT IN (?)", @lessons.map(&:id)).tagged_with(params[:tag])
      else
        @inactive_lessons = Offer.includes(:user, :meetings).where("lessons.id NOT IN (?)", @lessons.map(&:id))
      end
    end

    @selected_tag = ActsAsTaggableOn::Tag.where(name: params[:tag]).first if params[:tag]
    if params[:type] == "request"
      @lesson_tags = @lessons.map(&:tags)
    else
      @lesson_tags = (@lessons + @inactive_lessons).map(&:tags)
    end
    @lesson_tags = @lesson_tags.flatten.uniq.sort { |x,y| x.name <=> y.name }
    @lesson_tags = @lesson_tags + [@selected_tag] if params[:tag]

    # @booked_lessons = Offer.includes(:user, :meetings).where("meetings.start_time >= ?", Time.zone.now).order("meetings.start_time")
    # @booked_lessons = Offer.includes(:user, :meetings).where("lessons.id NOT IN (?)", @lessons.map(&:id)).where("meetings.start_time >= ?", Time.zone.now).order("meetings.start_time")
  end
end
