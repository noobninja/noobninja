class DonationsController < ApplicationController
  def index
    @donations = Donation.where(charity: "charity: water", counted: true)
    @total = @donations.present? ? (@donations.map(&:amount).inject(:+) / 100) : 0
  end
end
