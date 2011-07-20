class AddCompanyToLocation < ActiveRecord::Migration
  def self.up
    add_column :locations, :company, :boolean
  end

  def self.down
    remove_column :locations, :company
  end
end
