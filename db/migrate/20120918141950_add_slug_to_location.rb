class AddSlugToLocation < ActiveRecord::Migration
  def change
    add_column Location, :slug, :string
    add_index  Location, :slug, :unique => true
    # Location.unscoped.all.map(&:save!)
  end
end
