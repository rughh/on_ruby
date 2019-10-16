class AttachMaterialToTopic < ActiveRecord::Migration
  def change
    add_column :materials, :topic_id, :integer, index: true
  end
end
