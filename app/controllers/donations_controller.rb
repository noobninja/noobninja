class DonationsController < ApplicationController
  def index
    @donations = Donation.where(counted: true)
    @total = @donations.present? ? (@donations.map(&:amount).inject(:+) / 100) : 0
  end
end
