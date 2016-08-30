class AddPaperclipToComplaints < ActiveRecord::Migration
  def change
  	add_attachment :complaints, :image  
  end
end
