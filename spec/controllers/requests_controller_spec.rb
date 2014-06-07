require 'spec_helper'

describe RequestsController do
  before :all do
    FactoryGirl.create(:user)
  end

  before :each do
    ApplicationController.any_instance.stub(:current_user).and_return(User.first)
  end

  describe "Delete 'destroy'" do
    it "returns http success" do
      request = User.first.requests.create(FactoryGirl.attributes_for(:request))
      delete :destroy, id: request.id
      response.should be_success
    end

    it "removes record" do
      request = User.first.requests.create(FactoryGirl.attributes_for(:request))
      expect {
        delete :destroy, id: request.id
      }.to change{ Request.count }.by(-1)
    end
  end

  describe "Post 'create'" do
    context 'valid params' do
      it "returns http success" do
        post :create, request: FactoryGirl.attributes_for(:request)
        response.should be_success
      end
      it 'creates a new request' do
        expect {
          post :create, request: FactoryGirl.attributes_for(:request)
        }.to change { Request.count }.by(1)
      end
    end 
  end

  describe "Patch 'played'" do
    before :all do
      @party = User.first.parties.create(FactoryGirl.attributes_for(:party))
    end

    it "returns http success" do
      myRequest = User.first.requests.create(
        FactoryGirl.attributes_for(:request).merge({party_id: @party.id}))
      patch :played, id: myRequest.id
      response.should be_success
    end

    it "removes request from list" do
      myRequest = User.first.requests.create(
        FactoryGirl.attributes_for(:request).merge({party_id: @party.id}))
      expect {
        patch :played, id: myRequest.id
      }.to change { Request.count }.by(-1)
    end
  end

end
