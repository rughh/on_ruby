# frozen_string_literal: true

class AddSlugs < ActiveRecord::Migration
  def up
    [:users, :events].each do |table|
      add_column table, :slug, :string
      add_index  table, :slug, :unique => true
    end
  end

  def down
    [:users, :events].each do |table|
      remove_index  table, :slug
      remove_column table, :slug
    end
  end
end
