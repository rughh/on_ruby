class AddIndices < ActiveRecord::Migration
  def up
    add_index(:authorizations, [:user_id])
    add_index(:events, [:location_id])
    add_index(:events, [:user_id])
    add_index(:jobs, [:location_id])
    add_index(:materials, [:user_id])
    add_index(:materials, [:event_id])
    add_index(:participants, [:user_id])
    add_index(:participants, [:event_id])
    add_index(:slugs, %i[sluggable_id sluggable_type])
    add_index(:topics, [:user_id])
    add_index(:topics, [:event_id])
    add_index(:votes, [:wish_id])
    add_index(:votes, [:user_id])
    add_index(:wishes, [:user_id])
  end

  def down
    remove_index(:authorizations, [:user_id])
    remove_index(:events, [:location_id])
    remove_index(:events, [:user_id])
    remove_index(:jobs, [:location_id])
    remove_index(:materials, [:user_id])
    remove_index(:materials, [:event_id])
    remove_index(:participants, [:user_id])
    remove_index(:participants, [:event_id])
    remove_index(:slugs, %i[sluggable_id sluggable_type])
    remove_index(:topics, [:user_id])
    remove_index(:topics, [:event_id])
    remove_index(:votes, [:wish_id])
    remove_index(:votes, [:user_id])
    remove_index(:wishes, [:user_id])
  end
end
