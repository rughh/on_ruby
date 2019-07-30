# typed: false
class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.references :wish
      t.references :user
      t.integer :count
      t.text :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :votes
  end
end
