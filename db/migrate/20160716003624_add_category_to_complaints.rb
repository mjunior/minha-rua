class AddCategoryToComplaints < ActiveRecord::Migration
  def change
    add_reference :complaints, :category, index: true, foreign_key: true
  end
end
