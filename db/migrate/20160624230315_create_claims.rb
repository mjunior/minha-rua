class CreateClaims < ActiveRecord::Migration
  def change
    create_table :claims do |t|
    	t.decimal "lat", :precision => 10, :scale => 6,null:false
    	t.decimal "lng", :precision => 10, :scale => 6,null:false
    	t.text "body", null:false
    	t.integer :category_id
    	t.integer :user_id
    	t.string "city"
    	t.string "address"
    	t.integer "likes" 

       	t.timestamps null: false
    end
  end
end
