class OffersController < ApplicationController
  before_filter :authenticate_offer_user!, only: [:edit]

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

  def edit
    @offer = Offer.find(params[:id])
  end

  def update
    @offer = Offer.find(params[:id])

    respond_to do |format|
      if @offer.update_attributes(params[:offer])
        format.html { redirect_to current_user, notice: 'Lesson was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  private
  def authenticate_offer_user!
    @offer = Offer.find(params[:id])
    redirect_to root_path, notice: "You must be the owner of the lesson in order to edit it." unless current_user == @offer.user
  end
end
