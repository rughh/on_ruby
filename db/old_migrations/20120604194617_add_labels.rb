# typed: false
class AddLabels < ActiveRecord::Migration
  def change
    [:events, :highlights, :jobs, :locations].each do |table|
      add_column table, :label, :string, default: "hamburg"
    end
  end
end
