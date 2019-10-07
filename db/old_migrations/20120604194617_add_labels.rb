# frozen_string_literal: true

class AddLabels < ActiveRecord::Migration
  def change
    %i[events highlights jobs locations].each do |table|
      add_column table, :label, :string, default: 'hamburg'
    end
  end
end
