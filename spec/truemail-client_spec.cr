require "./spec_helper"

Spectator.describe "defined constants" do
  def const_defined?(const); !!const; end

  specify { expect(const_defined?(Truemail::Client::VERSION)).to be_true }
  specify { expect(const_defined?(Truemail::Client::Configuration)).to be_true }
  specify { expect(const_defined?(Truemail::Client::Http)).to be_true }
  specify { expect(const_defined?(Truemail::Client)).to be_true }
end
