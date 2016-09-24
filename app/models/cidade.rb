class Cidade < ActiveRecord::Base
  extend FriendlyId
  friendly_id :nome, use: :slugged
  belongs_to :estado
end
