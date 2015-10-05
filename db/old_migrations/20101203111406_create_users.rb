class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.string :nickname
      t.string :name
      t.string :image
      t.string :url
      t.string :location
      t.text :description

      t.timestamps
    end

    add_index :users, :nickname, :unique => true
  end

  def self.down
    drop_table :users
  end
end
