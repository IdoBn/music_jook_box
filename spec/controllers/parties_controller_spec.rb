require 'spec_helper'

describe PartiesController do
	context 'GET #index' do
		before(:each) { get :index }
		it { response.should be_success }
    it { expect(assigns(:parties)).to eq(Party.all.to_a) }
	end

	context 'GET #show' do
		let(:party) { FactoryGirl.create(:party) }
		before(:each) do
			get :show, id: party.id
		end
		it { response.should be_success }
    it { expect(assigns(:party)).to eq(party) }
	end

	context 'GET #search' do
		let(:party) { FactoryGirl.create(:party) }
		before(:all) do
			@videos = YouTubeIt::Client.new(:dev_key => Rails.application.secrets.youtube_dev_key)
				.videos_by(:query => 'cats', :per_page => 20 )
		end

		before(:each) { get :search, id: party.id ,songpull: 'cats' }
		it { response.should be_success }
  	it { expect(assigns(:videos)).to be_an_instance_of(YouTubeIt::Response::VideoSearch) }

	end
end
