class AddLimitToEvents < ActiveRecord::Migration
  def change
    add_column :events, :limit, :integer
  end
end
