class AddUserToComplaint < ActiveRecord::Migration
  def change
    add_reference :complaints, :user, index: true, foreign_key: true
  end
end
