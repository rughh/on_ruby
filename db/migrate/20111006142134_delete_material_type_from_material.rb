class DeleteMaterialTypeFromMaterial < ActiveRecord::Migration
  def up
    remove_column :materials, :material_type
  end

  def down
    add_column :materials, :done, :string
  end
end
