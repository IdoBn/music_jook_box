require 'spec_helper'

describe Request do
  it { should belong_to(:user) }
  it { should belong_to(:party) }
  it { should have_many(:likes) }

  it 'should have a default scope' do
  	request = FactoryGirl.create(:request)
  	request.played!
  	Request.all.include?(request).should be false
  end

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
