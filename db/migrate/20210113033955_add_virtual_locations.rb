class AddVirtualLocations < ActiveRecord::Migration[6.0]
  def change
    add_column :locations, :virtual, :boolean, default: false
    add_column :events, :remote_url, :string
  end
end
