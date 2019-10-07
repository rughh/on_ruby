# frozen_string_literal: true

class AddEmailtoUsers < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
  end
end
