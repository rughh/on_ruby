class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.timestamp :date
      t.text :description
      t.integer :location_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
