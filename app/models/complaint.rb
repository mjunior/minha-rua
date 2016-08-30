class Complaint < ActiveRecord::Base
	extend FriendlyId
	friendly_id :title, use: :slugged

	has_attached_file 	:image, styles: { original: "1200x1200>",medium: "500x500>",small:"200x200>", thumb: "100x100>" },
					 					convert_options: { 	small: 	"-quality 75 -strip",
						 									medium: "-quality 75 -strip",
						 									thumb: 	"-quality 75 -strip",
                                     						original: "-quality 85 -strip" },

						default_url: "/images/:style/missing.png",
						:path => ':rails_root/public/images/complaints/:id-:basename-:style.:extension',
                  		:url => '/images/complaints/:id-:basename-:style.:extension'
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

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
				##TO-DO: IMPLEMENTS NEW INTERACTIO DISLIKE
				logger.debug "DISLIKE DISLIKE"
			end
		end
		self.save
		interaction.save
	end
end
