class CreateComplaints < ActiveRecord::Migration
  def change
    create_table :complaints do |t|
      t.float :latitude
      t.float :longitude
      t.text :body
      t.string :address
      t.string :title
      t.string :city
      t.integer :likes

      t.timestamps null: false
    end
  end
end
