require 'spec_helper'

describe Request do
  it { should belong_to(:user) }
  it { should belong_to(:party) }

  it 'should have a default scope' do
  	request = FactoryGirl.create(:request)
  	request.played!
  	Request.all.include?(request).should be false
  end
end
