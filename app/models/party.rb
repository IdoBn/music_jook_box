class Party < ActiveRecord::Base
	belongs_to :user
	has_many :requests
end
