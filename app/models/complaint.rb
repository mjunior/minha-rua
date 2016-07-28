class Complaint < ActiveRecord::Base
	def to_param
	    [id, title.parameterize].join("-")
	end

	validates_presence_of :latitude,:longitude,:address, :message => "#!Não encontrado(a) forneça um novo endereço." 
	validates_presence_of :body, :message => "#!Forneça uma descrição para sua reclamação." 
	validates_presence_of :title, :message => "#!Forneça um título." 
	validates_presence_of :category, :message => "#!Escolha uma categoria." 

	belongs_to :category
	belongs_to :user
	has_many :interaction

	def addInteraction(interaction)
		if interaction.interaction_type.tag == 'LIKE'
			self.likes += 1
		else
			if interaction.interaction_type.tag == 'DISLIKE'
				logger.debug "DISLIKE DISLIKE"
			end
		end
		self.save
		interaction.save
	end
end
