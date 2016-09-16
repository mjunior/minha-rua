class CreateCidades < ActiveRecord::Migration
  def change
    create_table :cidades do |t|
      t.string :nome
      t.integer :codigo_ibge
      t.references :estado, index: true, foreign_key: true
      t.integer :populacao_2010
      t.float :densidade_demo
      t.string :gentilico
      t.float :area

      t.timestamps null: false
    end
  end
end
