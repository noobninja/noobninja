class OffersController < ApplicationController
  def new
    @offer = current_user.offers.new
    @offer.meetings.build

    respond_to do |format|
      format.html
      format.json { render json: @offer }
    end
  end

  def create
    @offer = current_user.offers.new(params[:offer])

    respond_to do |format|
      if @offer.save
        format.html { redirect_to lessons_path, notice: 'Lesson was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end
end
