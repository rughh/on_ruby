class AddLinkedinToUsers < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :linkedin, :string
  end
  def down
    remove_column :users, :linkedin
  end
end
