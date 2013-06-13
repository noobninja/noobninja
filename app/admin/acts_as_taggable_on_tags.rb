ActiveAdmin.register ActsAsTaggableOn::Tag do
  index do
    column :id
    column :name
    column :slug
  end
end
