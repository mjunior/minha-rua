class CreateInteractionTypes < ActiveRecord::Migration
  def change
    create_table :interaction_types do |t|
      t.string :title
      t.string :tag

      t.timestamps null: false
    end
  end
end
