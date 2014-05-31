class User < ActiveRecord::Base
	before_create :generate_access_token

	has_many :requests
	has_many :parties
	has_many :likes

	def self.omniauth(auth)
		profile = User.auth(auth[:access_token])
		where(uid: profile['id']).first_or_initialize.tap do |user|
	    user.oauth_token = auth[:access_token]
	    user.oauth_expires_at = Time.at(auth[:expires_in].to_i)
	    user.uid = profile["id"]
	    user.name =  "#{profile["first_name"]} #{profile["middle_name"]} #{profile["last_name"]}".split.join(" ")
	    user.email = profile["email"]
	    user.save!
	  end
	end

	def owns?(obj)
		obj.user == self
	end

	def thumbnail
		"http://graph.facebook.com/#{self.uid}/picture"
	end

	def self.auth(auth_token)
		Koala::Facebook::API.new(auth_token).get_object("me")
	end

private
	def generate_access_token
		begin
    	self.access_token = SecureRandom.hex
  	end while self.class.exists?(access_token: access_token)
	end
end
