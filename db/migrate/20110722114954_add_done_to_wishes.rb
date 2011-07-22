class AddDoneToWishes < ActiveRecord::Migration
  def self.up
    add_column :wishes, :done, :boolean
    Wish.update_all({done: true}, {id: [1, 2, 4, 5]})
  end

  def self.down
    remove_column :wishes, :done
  end
end
