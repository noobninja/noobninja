class Membership < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name, :stripe_card_token, :stripe_customer_id, :plan_id
  attr_accessor :stripe_card_token, :customer_only

  def save_membership
    if valid?
      customer = Stripe::Customer.create(card: stripe_card_token, plan: plan_id, description: "#{user.email} [#{user.name} - #{user.id}]")
      self.stripe_customer_id = customer.id
      save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
end