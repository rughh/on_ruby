# frozen_string_literal: true

class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :name
      t.string :url
      t.references :location

      t.timestamps
    end
  end
end
