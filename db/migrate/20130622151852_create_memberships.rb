class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.string :name
      t.string :stripe_customer_id
      t.integer :plan_id
      t.references :user

      t.timestamps
    end
  end
end
