ActiveAdmin.register User do
  menu priority: 1

  index do
    column :id
    column :first_name
    column :last_name
    column :image do |user|
      link_to image_tag(user.image_url(:thumb)), user if user.image
    end
    column :time_zone
    column :description
    column :tag_list
    column :created_at
    column :last_sign_in_at
    default_actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :member
      f.input :first_name
      f.input :last_name
      f.input :time_zone
      f.input :description, input_html: { rows: 3 }
    end
    f.actions
  end
end
