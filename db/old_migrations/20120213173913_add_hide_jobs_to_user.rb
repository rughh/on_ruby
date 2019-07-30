# typed: false
class AddHideJobsToUser < ActiveRecord::Migration
  def change
    add_column :users, :hide_jobs, :boolean, default: false
  end
end
