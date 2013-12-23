class CreateMaterials < ActiveRecord::Migration
  def self.up
    create_table :materials do |t|
      t.string :name
      t.text :description
      t.string :url
      t.string :type
      t.references :user
      t.references :event

      t.timestamps
    end
  end

  def self.down
    drop_table :materials
  end
end
