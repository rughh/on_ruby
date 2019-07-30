# typed: false
class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :name
      t.string :url
      t.string :street
      t.string :house_number
      t.string :city
      t.string :zip
      t.float :lat
      t.float :long

      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
