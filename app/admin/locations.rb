ActiveAdmin.register Location do
  form do |f|
     f.inputs "Details" do
       f.input :name
       f.input :url
       f.input :zip
       f.input :city
       f.input :street
       f.input :house_number
       f.input :company
     end
     f.buttons
   end

  index do
    column :id
    column :name
    column :url
    column :zip
    column :city
    column :street
    column :house_number
    column :company
    default_actions
  end
end
