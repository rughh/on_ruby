# typed: false
class AddDataToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :freelancer, :boolean
    add_column :users, :available, :boolean
  end

  def self.down
    remove_column :users, :available
    remove_column :users, :freelancer
  end
end
