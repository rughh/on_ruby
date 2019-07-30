# typed: false
class RenameTypeToMaterialType < ActiveRecord::Migration
  def self.up
    rename_column :materials, :type, :material_type
  end

  def self.down
    rename_column :materials, :material_type, :type
  end
end