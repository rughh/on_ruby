class AddSlugs < ActiveRecord::Migration
  def up
    [:users, :events, :wishes].each do |table|
      add_column table, :slug, :string
      add_index  table, :slug, :unique => true
      # "#{table}".singularize.capitalize.constantize.all.each do |model|
      #   puts "updating #{model.id}"
      #   model.save!
      # end
    end
  end

  def down
    [:users, :events, :wishes].each do |table|
      remove_index  table, :slug
      remove_column table, :slug
    end
  end
end
