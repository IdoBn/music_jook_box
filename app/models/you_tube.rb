class YouTube
	@@YOUTUBE_API_SERVICE_NAME = "youtube"
	@@YOUTUBE_API_VERSION = "v3"

	def initialize(key, default_search, default_per_page)
		@key = key

		@client = Google::APIClient.new(:key => key,
                               			:authorization => nil, 
                               			:application_name => "music",
                               			:application_version => 1.0)

		@youtube = @client.discovered_api(@@YOUTUBE_API_SERVICE_NAME, @@YOUTUBE_API_VERSION)

		@opts = Trollop::options do
		  opt :q, 'Search term', :type => String, :default => default_search
		  opt :maxResults, 'Max results', :type => :int, :default => default_per_page
		end

		@opts[:part] = 'id,snippet'
	end

	# def search(key_word: @opts[:q], per_page: @opts[:maxResults])
	def search(key_word)
		@opts[:q] = key_word
		# @opts[:maxResults] = per_page
 		@client.execute!(
		  :api_method => @youtube.search.list,
		  :parameters => @opts
		).data
	end
end
