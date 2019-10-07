# frozen_string_literal: true

class RemoveActivityFromWishes < ActiveRecord::Migration
  def self.up
    remove_column :wishes, :activity
  end

  def self.down
    add_column :wishes, :activity, :string
  end
end
