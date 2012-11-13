class AddVoteCacheToWish < ActiveRecord::Migration
  def self.up
    add_column :wishes, :stars, :integer, :default => 0

    Whitelabel.label = Whitelabel.labels.first
    Wish.unscoped.all.each do |wish|
      wish.update_stars!
    end
  end

  def self.down
    remove_column :wishes, :stars
  end
end
