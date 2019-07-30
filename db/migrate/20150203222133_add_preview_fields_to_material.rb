# typed: false
class AddPreviewFieldsToMaterial < ActiveRecord::Migration
  def change
    add_column :materials, :preview_type, :string
    add_column :materials, :preview_code, :string
  end
end
