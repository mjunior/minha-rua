class AddSlugToComplaint < ActiveRecord::Migration
  def change
    add_column :complaints, :slug, :string
    add_index :complaints, :slug, unique: true
  end
end
