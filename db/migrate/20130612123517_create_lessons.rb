class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :name
      t.string :type
      t.integer :amount
      t.text :description
      t.references :user

      t.timestamps
    end
    add_index :lessons, :user_id
  end
end
