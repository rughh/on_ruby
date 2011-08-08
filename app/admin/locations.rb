ActiveAdmin.register Location do
  form do |f|
     f.inputs "Details" do
       f.input :name
       f.input :url
       f.input :zip
       f.input :city
       f.input :street
       f.input :house_number
     end
     f.buttons
   end
end
