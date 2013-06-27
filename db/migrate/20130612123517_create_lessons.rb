class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.text :name
      t.string :type
      t.integer :amount
      t.text :description
      t.text :video_url
      t.boolean :booked, default: false
      t.boolean :donate, default: false
      t.references :user

      t.timestamps
    end
    add_index :lessons, :user_id
  end
end
