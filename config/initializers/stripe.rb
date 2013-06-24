if Rails.env.production?
  Stripe.api_key = ENV['STRIPE_API_KEY']
  STRIPE_PUBLIC_KEY = ENV['STRIPE_PUBLIC_KEY']
else
  Stripe.api_key = ENV['STRIPE_TEST_API_KEY']
  STRIPE_PUBLIC_KEY = ENV['STRIPE_TEST_PUBLIC_KEY']
end