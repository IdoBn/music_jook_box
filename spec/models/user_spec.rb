require 'spec_helper'

describe User do
  it { should have_many(:parties) }
  it { should have_many(:requests) }
  it { should have_many(:likes) }

  # methods
  it { should respond_to(:owns?) }
  it { should respond_to(:thumbnail) }
end
