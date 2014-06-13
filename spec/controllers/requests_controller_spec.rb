require 'spec_helper'

describe RequestsController do
  before :all do
    FactoryGirl.create(:user)
  end

  before :each do
    ApplicationController.any_instance.stub(:current_user).and_return(User.first)
  end

  describe 'POST #like' do
    before(:each) do
      @party = User.first.parties.create(FactoryGirl.attributes_for(:party))
      @my_request = User.first.requests.create(FactoryGirl.attributes_for(:request).merge({party_id: @party.id}))
    end

    context 'does not like' do
      # before(:each) { User.first.likes.create(request: @myRequest) }
      it 'should change request likes by 1' do
        expect {
          post :like, id: @my_request.id
        }.to change{ @my_request.likes.count }.by(1)
      end
    end

    context 'already likes' do
      it 'should change request likes by 0' do
        User.first.likes.create(request: @my_request)
        expect {
          post :like, id: @my_request.id
        }.to_not change{ @my_request.likes.count }
      end
    end

    context 'not signed in' do
      before :each do
        ApplicationController.any_instance.unstub(:current_user)
      end

      it 'should change request likes by 0' do
        expect {
          post :like, id: @my_request.id
        }.to_not change{ @my_request.likes.count }
      end
    end
  end

  describe 'DELETE #unlike' do
    before(:each) do
      @party = User.first.parties.create(FactoryGirl.attributes_for(:party))
      @my_request = User.first.requests.create(FactoryGirl.attributes_for(:request).merge({party_id: @party.id}))
    end

    # context 'does not like' do
    #   # before(:each) { User.first.likes.create(request: @myRequest) }
    #   it 'should change request likes by 0' do
    #     expect {
    #       delete :unlike, id: @my_request.id
    #     }.to_not change{ @my_request.likes.count }
    #   end
    # end

    context 'already likes' do
      it 'should change request likes by -1' do
        User.first.likes.create(request: @my_request)
        expect {
          delete :unlike, id: @my_request.id
        }.to change{ @my_request.likes.count }.by(-1)
      end
    end

    context 'not signed in' do
      before :each do
        ApplicationController.any_instance.unstub(:current_user)
      end

      it 'should change request likes by 0' do
        expect {
          delete :unlike, id: @my_request.id
        }.to_not change{ @my_request.likes.count }
      end
    end
  end

  describe "Delete 'destroy'" do
    context 'owns request' do
      before(:each) { @myRequest = User.first.requests.create(FactoryGirl.attributes_for(:request)) }

      it "returns http success" do
        delete :destroy, id: @myRequest.id
        response.should be_success
      end

      it "removes record" do
        expect {
          delete :destroy, id: @myRequest.id
        }.to change{ Request.count }.by(-1)
      end
    end

    context 'owns party' do
      before :each do
        @user = FactoryGirl.create(:user)
        @party = @user.parties.create(FactoryGirl.attributes_for(:party))
        @myRequest = User.first.requests.create(
          FactoryGirl.attributes_for(:request).merge({party_id: @party.id}))
      end

      it "returns http success" do
        delete :destroy, id: @myRequest.id
        response.should be_success
      end

      it "removes record" do
        expect {
          delete :destroy, id: @myRequest.id
        }.to change{ Request.count }.by(-1)
      end
    end

    context 'does not own request or party' do
      before :each do
        @user = FactoryGirl.create(:user)
        @party = @user.parties.create(FactoryGirl.attributes_for(:party))
        @myRequest = @user.requests.create(
          FactoryGirl.attributes_for(:request).merge({party_id: @party.id}))
      end

      it "removes record" do
        expect {
          delete :destroy, id: @myRequest.id
        }.to_not change{ Request.count }
      end
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

    context 'invalid params' do
      before(:each) { Request.any_instance.stub(:valid?).and_return(false) }

      it 'creates a new request' do
        expect {
          post :create, request: FactoryGirl.attributes_for(:request)
        }.to_not change { Request.count }
      end
    end

    context 'user not signed in' do
      before(:each) { ApplicationController.any_instance.stub(:current_user).and_return(nil) }

      it 'creates a new request' do
        expect {
          post :create, request: FactoryGirl.attributes_for(:request)
        }.to_not change { Request.count }
      end
    end
  end

  describe "Patch 'played'" do
    before :all do
      @party = User.first.parties.create(FactoryGirl.attributes_for(:party))
      @myRequest = User.first.requests.create(
        FactoryGirl.attributes_for(:request).merge({party_id: @party.id}))
    end

    context 'owns party' do
      it "returns http success" do
        patch :played, id: @myRequest.id
        response.should be_success
      end

      it "removes request from list" do
        expect {
          patch :played, id: @myRequest.id
        }.to change { Request.count }.by(-1)
      end
    end

    context 'does not own party' do
      before :each do
        ApplicationController.any_instance.unstub(:current_user)
      end

      it 'returns http error' do
        patch :played, id: @myRequest.id
        response.should_not be_success
      end

      it 'does not remove request from list' do
        expect {
          patch :played, id: @myRequest.id
        }.to_not change { Request.count }
      end
    end
  end

end
