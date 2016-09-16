class AddCidadeToComplaint < ActiveRecord::Migration
  def change
    add_reference :complaints, :cidade, index: true, foreign_key: true
  end
end
