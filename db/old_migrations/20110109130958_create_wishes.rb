# frozen_string_literal: true

class CreateWishes < ActiveRecord::Migration
  def self.up
    create_table :wishes do |t|
      t.string :name
      t.text :description
      t.string :activity
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :whishes
  end
end
