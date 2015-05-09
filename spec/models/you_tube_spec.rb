require 'spec_helper'

describe YouTube do

	let(:youtube) { YouTube.new(Rails.application.secrets.youtube_dev_key, 'music', 25) }

	describe 'search' do 
		it 'should have a response' do
			data = youtube.search('maroon 5')
			data.should_not be_nil
		end
	end
end