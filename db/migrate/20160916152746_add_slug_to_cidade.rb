class AddSlugToCidade < ActiveRecord::Migration
  def change
    add_column :cidades, :slug, :string
    add_index :cidades, :slug, unique: true
  end
end
