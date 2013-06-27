class MembershipsController < ApplicationController
  def new
    @membership = Membership.new
  end

  def create
    @membership = Membership.new(params[:membership])
    @membership.user = current_user
    @plan_id = params[:membership][:plan_id].to_i

    if @membership.save_membership
      current_user.update_attributes(name: @membership.name) if @membership.name != current_user.name
      redirect_to lessons_path, notice: @plan_id == 1 ? "Bank account verified! You can now start collecting tips for giving lessons." : "Thanks for subscribing. You can now give and get lessons, as well as earn tips and donate!"
    else
      render :new
    end
  end

  def edit
     @membership = current_user.membership
     @created_at = current_user.membership.created_at if current_user.membership
  end

  def update
    @membership = current_user.membership
    @plan_id = params[:membership][:plan_id].to_i
    @customer = Stripe::Customer.retrieve(@membership.stripe_customer_id)
    if @membership.plan_id > @plan_id
      @customer.update_subscription(plan: @plan_id, prorate: false)
    else
      @customer.update_subscription(plan: @plan_id)
    end

    if @membership.update_attributes(plan_id: @plan_id)
      respond_to do |format|
        format.html { redirect_to lessons_path, notice: 'Subscription successfully updated.' }
      end
    end
  end
end
