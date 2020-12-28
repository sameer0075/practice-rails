class AddUserToNotes < ActiveRecord::Migration[6.0]
  def change
    add_reference :notes, :user, foreign_key: true
  end
end
