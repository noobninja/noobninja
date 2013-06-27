class DonationsController < ApplicationController
  def index
    @donations = Donation.where(counted: true)
    @total = @donations.map(&:amount).inject(:+) / 100
  end
end
