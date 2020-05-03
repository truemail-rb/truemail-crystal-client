require "../../spec_helper"

Spectator.describe Truemail::Client::Http do
  include RequestHelper

  let(:secure_connection) { true }
  let(:host) { "example.com" }
  let(:port) { 8080 }
  let(:token) { "some_token" }

  describe "defined constants" do
    it { expect(Truemail::Client::Http::USER_AGENT).to be_an_instance_of(String) }
    it { expect(Truemail::Client::Http::MIME_TYPE).to be_an_instance_of(String) }
  end

  describe ".new" do
    subject(:http_instance) do
      described_class.new(secure_connection: secure_connection, host: host, port: port, token: token)
    end

    it "returns http instance with custom values" do
      expect(http_instance.host).to eq(host)
      expect(http_instance.token).to eq(token)
      expect(http_instance.port).to eq(port)
      expect(http_instance.secure_connection).to be(secure_connection)
    end
  end

  describe "#run" do
    subject(:run) { described_class.new(secure_connection: secure_connection, host: host, port: port, token: token).run(email) }

    let(:email) { "some_email@example.com" }

    context "when connection successful" do
      let(:app_type) { "application/json" }
      let(:request_settings) do
          {
            method: :get,
            accept: app_type,
            content_type: app_type,
            user_agent: "Truemail Crystal client",
            email: email,
            host: host,
            port: port,
            token: token,
            secure_connection: secure_connection
          }
        end

      context "when secure connection" do
        it "sends valid request to truemail api, returns json response" do
          have_sent_request_with(**request_settings)
          expect(run).to eq(truemail_json_response(email))
        end
      end

      context "when not secure connection" do
        let(:secure_connection) { false }

        it "sends valid request to truemail api, returns json response" do
          have_sent_request_with(**request_settings)
          expect(run).to eq(truemail_json_response(email))
        end
      end
    end

    context "when connection fails" do
      mock HTTP::Client do
        stub self.get(url : String | URI, headers : HTTP::Headers? = nil)
      end

      let(:error) { "some error context" }

      it "returns json with client error message" do
        client, exception = HTTP::Client, Exception.new(error)
        allow(client).to receive(:get).and_raise(exception)
        expect(run).to eq("{\"truemail_client_error\":\"#{error}\"}")
      end
    end
  end
end
