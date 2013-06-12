ActiveAdmin.register Lesson do
  index do
    column :name
    column :amount
    column :description
    column :tag_list
    column :created_at
    column :updated_at
  end
end
