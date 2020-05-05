require "../../spec_helper"

Spectator.describe Truemail::Client::Configuration do
  include RequestHelper

  let(:secure_connection) { true }
  let(:host) { "example.com" }
  let(:port) { 80 }
  let(:token) { "token" }

  describe "defined constants" do
    it { expect(Truemail::Client::Configuration::DEFAULT_PORT).to be_an_instance_of(Int32) }
    it { expect(Truemail::Client::Configuration::DEFAULT_VALUE).to be_an_instance_of(String) }
  end

  describe ".new" do
    context "with defaults params" do
      subject(:configuration_instance) { described_class.new { |config| config.secure_connection = false } }

      it "creates configuration instance with defaults params" do
        expect(configuration_instance.secure_connection).to be_false
        expect(configuration_instance.host).to eq(Truemail::Client::Configuration::DEFAULT_VALUE)
        expect(configuration_instance.port).to eq(Truemail::Client::Configuration::DEFAULT_PORT)
        expect(configuration_instance.token).to eq(Truemail::Client::Configuration::DEFAULT_VALUE)
      end
    end

    context "with custom params" do
      subject(:configuration_instance) do
        described_class.new do |config|
          config.secure_connection = secure_connection
          config.host = host
          config.port = port
          config.token = token
        end
      end

      it "creates configuration instance with custom params" do
        expect(configuration_instance.secure_connection).to eq(secure_connection)
        expect(configuration_instance.host).to eq(host)
        expect(configuration_instance.port).to eq(port)
        expect(configuration_instance.token).to eq(token)
      end
    end
  end

  describe "#settings" do
    subject(:configuration_instance_settings) do
      described_class.new do |config|
        config.secure_connection = secure_connection
        config.host = host
        config.port = port
        config.token = token
      end.settings
    end

    it "returns hash with configuration instance settings" do
      expect(configuration_instance_settings).to eq(
        {
          secure_connection: secure_connection,
          host: host,
          port: port,
          token: token
        }
      )
    end
  end

  describe "#not_complete?" do
    context "when configuration instance is complete" do
      subject(:configuration_instance) do
        described_class.new do |config|
          config.host = host
          config.token = token
        end
      end

      specify { expect(configuration_instance.not_complete?).to be_false }
    end

    context "when configuration instance is incomplete" do
      subject(:configuration_instance) { described_class.new { |config| config.port = 80 } }

      specify { expect(configuration_instance.not_complete?).to be_true }
    end
  end
end
