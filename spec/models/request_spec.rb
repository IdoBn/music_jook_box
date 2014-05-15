require 'spec_helper'

describe Request do
  it { should belong_to(:user) }
  it { should belong_to(:party) }
end
