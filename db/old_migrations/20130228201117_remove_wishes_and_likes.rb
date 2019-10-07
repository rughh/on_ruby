# frozen_string_literal: true

class RemoveWishesAndLikes < ActiveRecord::Migration
  def change
    drop_table :wishes
    drop_table :votes
  end
end
