class Like < ActiveRecord::Base
	after_create :position_up
	after_destroy :position_down

	belongs_to :user
	belongs_to :request
end
