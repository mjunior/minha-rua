class Interaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :interaction_type
  belongs_to :complaint
end
