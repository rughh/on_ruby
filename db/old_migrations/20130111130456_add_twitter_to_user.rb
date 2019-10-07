# frozen_string_literal: true

class AddTwitterToUser < ActiveRecord::Migration
  def change
    add_column User, :twitter, :string
  end
end
