require 'spec_helper'

describe RequestsController do

  describe "GET 'destroy'" do
    it "returns http success" do
      request = FactoryGirl.create(:request)
      delete :destroy, id: request.id
      response.should be_success
    end

    it "removes record" do
      request = FactoryGirl.create(:request)
      expect {
        delete :destroy, id: request.id
      }.to change{ Request.count }.by(-1)
    end
  end

  describe "GET 'create'" do
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

  describe "GET 'played'" do
    let(:request) { FactoryGirl.create(:request) }
    before(:each) { request }

    it "returns http success" do
      patch :played, request_id: request.id
      response.should be_success
    end

    it "returns http success" do
      expect {
        patch :played, request_id: request.id
      }.to change { Request.count }.by(-1)
    end
  end

end
