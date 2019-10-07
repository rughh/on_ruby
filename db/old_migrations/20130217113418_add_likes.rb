# frozen_string_literal: true

class AddLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :user
      t.references :topic

      t.timestamps
    end

    add_column Topic, :label, :string, default: 'hamburg'
    add_column Topic, :slug, :string
  end
end
