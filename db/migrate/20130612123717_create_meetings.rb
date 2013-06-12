class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.datetime :start_time
      t.integer :duration
      t.integer :capacity
      t.boolean :booked
      t.boolean :adjourned
      t.references :lesson

      t.timestamps
    end
    add_index :meetings, :lesson_id
  end
end
