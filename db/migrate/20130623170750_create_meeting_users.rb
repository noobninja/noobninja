class CreateMeetingUsers < ActiveRecord::Migration
  def change
    create_table :meeting_users do |t|
      t.references :meeting
      t.references :user

      t.timestamps
    end
    add_index :meeting_users, :meeting_id
    add_index :meeting_users, :user_id
  end
end
