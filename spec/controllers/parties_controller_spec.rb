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

	context 'POST #create' do
		context 'user signed in' do
			before :each do
				ApplicationController.any_instance.stub(:current_user).and_return(User.first)
			end

			it 'should change Party.count by 1' do
				expect {
					post :create, party: FactoryGirl.attributes_for(:party)
				}.to change{ Party.count }.by(1)
			end

			it 'should change current_user.parties.count by 1' do
				expect {
					post :create, party: FactoryGirl.attributes_for(:party)
				}.to change{ User.first.parties.count }.by(1)
			end
		end

		context 'user not signed in' do
			it 'should change Party.count by 1' do
				expect {
					post :create, party: FactoryGirl.attributes_for(:party)
				}.to_not change{ Party.count }
			end

			it 'should change current_user.parties.count by 1' do
				expect {
					post :create, party: FactoryGirl.attributes_for(:party)
				}.to_not change{ User.first.parties.count }
			end
		end
	end
end
