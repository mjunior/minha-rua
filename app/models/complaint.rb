class Complaint < ActiveRecord::Base
	def to_param
	    [id, title.parameterize].join("-")
	end
	belongs_to :category
	belongs_to :user
end
