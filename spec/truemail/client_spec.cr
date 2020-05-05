require "../spec_helper"

Spectator.describe Truemail::Client do
  include RequestHelper

  describe ".validate" do
    subject { described_class.validate(email, configuration_instance) }

    let(:email) { "email@example.com" }
    let(:secure_connection) { true }
    let(:host) { "example.com" }
    let(:port) { 80 }
    let(:token) { "token" }

    context "when configuration instance is incomplete" do
      let(:configuration_instance) do
        Truemail::Client::Configuration.new do |config|
          config.secure_connection = secure_connection
          config.host = host
          config.port = port
        end
      end

      specify { expect { subject }.to raise_error(Truemail::Client::Configuration::INCOMPLETE_CONFIG) }
    end

    context "when configuration instance is complete" do
      let(:configuration_instance) do
        Truemail::Client::Configuration.new do |config|
          config.secure_connection = secure_connection
          config.host = host
          config.port = port
          config.token = token
        end
      end

      it "sends valid request to truemail api, returns json response" do
        allow(Truemail::Client::Http).to receive(:new).and_call_original
        have_sent_request_with(
          method: :get,
          accept: "application/json",
          content_type: "application/json",
          user_agent: "Truemail Crystal client",
          email: email,
          host: host,
          port: port,
          token: token,
          secure_connection: secure_connection
        )
        expect(subject).to eq(truemail_json_response(email))
      end
    end
  end
end
