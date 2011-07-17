class CreateUsergroups < ActiveRecord::Migration
  def self.up
    create_table :usergroups do |t|
      t.string :name
      t.string :url
      t.string :twitter

      t.timestamps
    end
  end

  def self.down
    drop_table :usergroups
  end
end
