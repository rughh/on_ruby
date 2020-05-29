class AddAttendeeInformations < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :attendee_information, :text
  end
end
