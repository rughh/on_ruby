class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.string :name
      t.text :description
      t.references :user
      t.references :event

      t.timestamps
    end
  end

  def self.down
    drop_table :topics
  end
end
