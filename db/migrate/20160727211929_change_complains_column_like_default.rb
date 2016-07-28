class ChangeComplainsColumnLikeDefault < ActiveRecord::Migration
  def change
  	change_column :complaints, :likes, :integer, :default => 0
  end
end
