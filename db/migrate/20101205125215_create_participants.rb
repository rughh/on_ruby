class CreateParticipants < ActiveRecord::Migration
  def self.up
    create_table :participants do |t|
      t.integer :user_id
      t.integer :event_id
      t.boolean :maybe

      t.timestamps
    end
  end

  def self.down
    drop_table :participants
  end
end
