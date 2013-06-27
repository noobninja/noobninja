class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.string :charity
      t.integer :amount
      t.integer :via_user_id
      t.boolean :counted, default: false
      t.references :user
      t.references :lesson

      t.timestamps
    end
    add_index :donations, :user_id
  end
end
