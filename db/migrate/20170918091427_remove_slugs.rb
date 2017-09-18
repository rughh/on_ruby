class RemoveSlugs < ActiveRecord::Migration
  def change
    remove_column Topic, :slug
    remove_column Event, :slug
    remove_column User, :slug
    remove_column Location, :slug
  end
end
