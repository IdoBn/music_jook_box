class Like < ActiveRecord::Base
	before_create :position_up
	before_destroy :position_down

	belongs_to :user
	belongs_to :request

	validates :user_id, :uniqueness => { :scope => :request_id }

	def position_up
		unless self.request.party.requests.first == self.request || self.request.party.requests.second == self.request
			requests = self.request.party.requests.not_played
			req1_index = requests.index(self.request)
			req2_index = req1_index - 1
			temp_position = requests[req1_index].position
			self.request.update_attribute(:position, requests[req2_index].position)
			requests[req2_index].update_attribute(:position, temp_position)
		end
	end

	def position_down
		unless self.request.party.requests.first == self.request || self.request.party.requests.last == self.request
			requests = self.request.party.requests.not_played
			req1_index = requests.index(self.request)
			req2_index = req1_index + 1
			temp_position = requests[req1_index].position
			self.request.update_attribute(:position, requests[req2_index].position)
			requests[req2_index].update_attribute(:position, temp_position)
		end
	end
end
