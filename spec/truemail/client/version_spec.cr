require "../../spec_helper"

Spectator.describe Truemail::Client::VERSION do
  it "should have version" do
    is_expected.to be_an_instance_of(String)
  end
end
