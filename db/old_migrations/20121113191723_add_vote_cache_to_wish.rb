# frozen_string_literal: true

class AddVoteCacheToWish < ActiveRecord::Migration
  def self.up
    add_column :wishes, :stars, :integer, :default => 0
  end

  def self.down
    remove_column :wishes, :stars
  end
end
