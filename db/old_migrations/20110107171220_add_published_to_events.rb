class AddPublishedToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :published, :boolean
  end

  def self.down
    remove_column :events, :published
  end
end