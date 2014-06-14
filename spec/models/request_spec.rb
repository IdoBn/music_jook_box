require 'spec_helper'

describe Request do
  it { should belong_to(:user) }
  it { should belong_to(:party) }
  it { should have_many(:likes) }

  # methods

  context '#played' do
    it { should respond_to(:played?) }

    it 'returns false if played' do
      request = Request.new(played: false)
      request.played?.should be_false
    end

    it 'returns true if played' do
      request = Request.new(played: true)
      request.played?.should be_true
    end
  end

  context '#set_position' do
    it { should respond_to(:set_position) }

    it 'should set position' do
      request = FactoryGirl.create(:request)
      request.position.should be(1)
    end

    it 'should increment position' do
      party = FactoryGirl.create(:party)
      party.requests.create(FactoryGirl.attributes_for(:request))
      request = party.requests.create(FactoryGirl.attributes_for(:request))
      request.position.should be(2)
    end
  end

  it 'should have a default scope' do
  	request = FactoryGirl.create(:request)
  	request.played!
  	Request.all.include?(request).should be false
  end
end
