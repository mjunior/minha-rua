class CreateInteractions < ActiveRecord::Migration
  def change
    create_table :interactions do |t|
      t.references :user, index: true, foreign_key: true
      t.references :interaction_type, index: true, foreign_key: true
      t.references :complaint, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
