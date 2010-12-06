class AddStuffToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :twitter, :string
    add_column :users, :github, :string
    add_column :users, :homepage, :string
    add_column :users, :company, :string
  end

  def self.down
    remove_column :users, :company
    remove_column :users, :homepage
    remove_column :users, :github
    remove_column :users, :twitter
  end
end
