# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.timestamp :date
      t.text :description
      t.references :location
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
