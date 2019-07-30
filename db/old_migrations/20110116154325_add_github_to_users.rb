# typed: false
class AddGithubToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :github, :string
  end

  def self.down
    remove_column :users, :github
  end
end
