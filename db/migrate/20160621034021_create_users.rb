class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string "email", null:false
    	t.string "first_name",null:false
    	t.string "last_name"
    	t.string "bio"
    	t.string "facebook_url"
    	t.string "twitter_url"
    	t.string "instagram_url"
    	t.timestamps null: false
    end
  end
end
