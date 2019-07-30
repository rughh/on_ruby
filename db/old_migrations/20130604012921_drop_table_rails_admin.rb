# typed: false
class DropTableRailsAdmin < ActiveRecord::Migration
  def change
    remove_index :rails_admin_histories, :index_histories_on_item_and_table_and_month_and_year if index_exists? :rails_admin_histories, :index_histories_on_item_and_table_and_month_and_year
    drop_table :rails_admin_histories
  end
end
