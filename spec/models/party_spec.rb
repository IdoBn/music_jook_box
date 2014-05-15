require 'spec_helper'

describe Party do
  it { should have_many(:requests) }
  it { should belong_to(:user) }
end
