require 'spec_helper'

describe UsersController do
  before(:all) { FactoryGirl.create(:user) }

  context 'GET show' do
    before(:each) do
      get :show, id: User.first.id
    end

    it { response.should be_success }
    it { expect(assigns(:user)).to eq(User.first) }
  end
end
