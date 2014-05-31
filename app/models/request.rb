class Request < ActiveRecord::Base
	belongs_to :user
	belongs_to :party
	has_many :likes

	default_scope { not_played }
	scope :not_played, -> { where(played: false) }

	def played?
  	self.played ? true : false
  end

  def played!
  	self.update_attribute(:played, true) unless played?
  end
end
