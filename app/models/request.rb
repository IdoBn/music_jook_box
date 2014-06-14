class Request < ActiveRecord::Base
	before_create :set_position

	belongs_to :user
	belongs_to :party
	has_many :likes

	default_scope { not_played }
	scope :not_played, -> { where(played: false).order(:position) }

	def coords(latitude: 1.0, longitude: 1.0)
		party.update_attributes(latitude: latitude, longitude: longitude)
	end

	def played?
  	self.played ? true : false
  end

  def played!
  	self.update_attribute(:played, true) unless played?
  end

  def set_position
  	begin
  		self.position = self.party.requests.last.position + 1
  	rescue
  		self.position = 1
  	end
  end
end
