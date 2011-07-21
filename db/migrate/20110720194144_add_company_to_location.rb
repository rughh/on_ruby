# encoding: UTF-8
class AddCompanyToLocation < ActiveRecord::Migration
  def self.up
    add_column :locations, :company, :boolean
    Location.update_all({company: true}, {name: ["blau Mobilfunk GmbH", "Qype GmbH", "Tolingo GmbH", "XING AG"]})
    Location.create!(name: 'mindmatters GmbH & Co. KG', url: 'http://mindmatters.de', street: 'Neuer Kamp', house_number: '30', city: 'Hamburg', zip: '20357', lat: 53.557646, long: 9.96769, company: true)
    Location.create!(name: 'tmp8 GmbH Softwareentwicklung Softwarevertrieb IT-Beratung', url: 'tmp8.de', street: 'Sternstraße', house_number: '106', city: 'Hamburg', zip: '20357', lat: 53.561673, long: 9.967947, company: true)
    Location.create!(name: 'Avocado Store GmbH', url: 'http://avocadostore.de', street: 'Schulterblatt', house_number: '36', city: 'Hamburg', zip: '20357', lat: 53.56059, long: 9.963119, company: true)
    Location.create!(name: 'Ubilabs GmbH Internet', url: 'http://ubilabs.net', street: 'Juliusstraße', house_number: '25', city: 'Hamburg', zip: '22769', lat: 53.561108, long: 9.961681, company: true)
    Location.create!(name: 'lb-lab GmbH', url: 'http://lb-lab.de', street: 'Burchardstraße', house_number: '19', city: 'Hamburg', zip: '20095', lat: 53.549253, long: 10.000313, company: true)
    Location.create!(name: 'Dynport GmbH', url: 'http://dynport.de', street: 'Große Theaterstraße', house_number: '39', city: 'Hamburg', zip: '20354', lat: 53.556385, long: 9.990486, company: true)
    Location.create!(name: 'Akra GmbH', url: 'http://akra.de', street: 'Domstraße', house_number: '17', city: 'Hamburg', zip: '20357', lat: 53.548191, long: 9.994548, company: true)
  end
  
  def self.down
    remove_column :locations, :company
  end
end
