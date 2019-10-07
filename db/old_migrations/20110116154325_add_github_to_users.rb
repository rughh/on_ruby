# frozen_string_literal: true

class AddGithubToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :github, :string
  end

  def self.down
    remove_column :users, :github
  end
end
