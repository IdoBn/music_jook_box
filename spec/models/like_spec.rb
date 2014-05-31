require 'spec_helper'

describe Like do
  it { should belong_to(:user) }
  it { should belong_to(:request) }

  context 'position' do
  	before(:each) do
  		@party = FactoryGirl.create(:party)
  		4.times { @party.requests.create(FactoryGirl.attributes_for(:request)) }
  	end

  	# it 'should recieve position up' do
  	# 	expect(@party.requests.last.likes.create).to receive(:position_up)
  	# end

  	# it 'should raise position' do
  	# 	expect {
  	# 		@party.requests.last.likes.create
  	# 	}.to change{ @party.requests.last.position }
  	# end
  end
end
