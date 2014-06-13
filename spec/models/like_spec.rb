require 'spec_helper'

describe Like do
  it { should belong_to(:user) }
  it { should belong_to(:request) }

  context 'position' do
  	before(:each) do
  		@party = FactoryGirl.create(:party)
  		4.times { @party.requests.create(FactoryGirl.attributes_for(:request)) }
      @like = @party.requests.last.likes.build(user: User.first)
  	end

  	it { expect(@like).to respond_to(:position_up) }

  	it 'should raise position' do
  		expect {
  			@like.save
  		}.to change{ @party.requests.last }
  	end

    it 'should lower position on delete' do
      like = @party.requests.last.likes.build(user: User.first)
      like.save
      expect {
        like.destroy
      }.to change{ @party.requests.last }
    end
  end
end
