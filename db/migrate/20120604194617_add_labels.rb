class AddLabels < ActiveRecord::Migration
  def change
    [:events, :highlights, :jobs, :locations, :wishes].each do |table|
      add_column table, :label, :string, default: "hamburg"
    end
  end
end
