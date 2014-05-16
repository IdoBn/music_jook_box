class User < ActiveRecord::Base
	has_many :requests
	has_many :parties

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

	def facebook
	  @facebook ||= Koala::Facebook::API.new(oauth_token)
	  block_given? ? yield(@facebook) : @facebook
	rescue Koala::Facebook::APIError => e
	  logger.info e.to_s
	  nil # or consider a custom null object
	end
end
