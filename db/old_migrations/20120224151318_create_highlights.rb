# typed: false
class CreateHighlights < ActiveRecord::Migration
  def change
    create_table :highlights do |t|
      t.string :description
      t.string :url
      t.timestamp :start_at
      t.timestamp :end_at

      t.timestamps
    end
  end
end
