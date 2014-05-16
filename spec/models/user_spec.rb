require 'spec_helper'

describe User do
  it { should have_many(:parties) }
  it { should have_many(:requests) }
end
