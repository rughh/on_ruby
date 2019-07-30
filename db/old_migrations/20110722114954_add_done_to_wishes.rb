# typed: false
class AddDoneToWishes < ActiveRecord::Migration
  def self.up
    add_column :wishes, :done, :boolean, default: false
  end

  def self.down
    remove_column :wishes, :done
  end
end
