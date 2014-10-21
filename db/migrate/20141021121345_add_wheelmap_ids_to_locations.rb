class AddWheelmapIdsToLocations < ActiveRecord::Migration
  # add id to reference locations at wheelmap.org
  def change
  	add_column :locations, :wheelmap_id, :integer
  end
end
